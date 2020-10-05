resource "aws_lb" "url_shortener_alb" {
  name               = var.alb_name
  internal           = var.alb_internal
  load_balancer_type = "application"
  security_groups    = var.alb_sg_id   # Optional
  subnets            = var.alb_subnets # Optional

  enable_deletion_protection = true

  tags = {
    Environment = var.env
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

module "url_shortener_ecs_service" {
  source  = "../ecs_service"
  cluster = var.ecs_cluster
  vpc_id  = var.vpc_id
}
