module "url_shortener_service" {
  source      = "../ecs_service"
  environment = var.environment
  region      = var.region
  cluster     = var.ecs_cluster
  vpc_id      = var.vpc_id
  name        = var.name
  db_image    = var.db_image
}

resource "aws_lb" "url_shortener_alb" {
  name               = "${var.name}-alb"
  internal           = var.alb_internal
  load_balancer_type = "application"
  security_groups    = [aws_security_group.url_shortener_alb_sg.id]
  subnets            = var.alb_subnets # Optional

  enable_deletion_protection = true

  tags = {
    TFManaged   = true
    Environment = var.environment
    Project     = "unity_url_shortener"
  }
}

resource "aws_security_group" "url_shortener_alb_sg" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic to the load balancer"
  vpc_id      = var.vpc_id

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    TFManaged   = true
    Environment = var.environment
    Project     = "unity_url_shortener"
  }
}



# resource "aws_kms_key" "a" {
#   description = "KMS key 1"

# }

# resource "aws_kms_alias" "a" {
#   name          = "alias/my-key-alias"
#   target_key_id = aws_kms_key.a.key_id
# }
