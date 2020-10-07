data "aws_iam_policy_document" "url_shortener_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}


### IAM Task Execution role

resource "aws_iam_role" "url_shortening_execution_role" {
  name               = "${var.environment}-url_shortening_execution_role"
  description        = "The Execution Role is assumed by ECS & Fargate on our behalf when managing the server. It allows logs to be written to CloudWatch."
  assume_role_policy = data.aws_iam_policy_document.url_shortener_assume_role_policy.json
}


resource "aws_iam_policy" "url_shortening_execution_role_policy" {
  name        = "url_shortening_execution_role_policy"
  description = "url_shortening_execution_role_policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}  
EOF
}

resource "aws_iam_policy_attachment" "url_shortening_execution_role_policy" {
  name       = "url_shortening_execution_role_policy-attachment"
  roles      = [aws_iam_role.url_shortening_execution_role.name]
  policy_arn = aws_iam_policy.url_shortening_execution_role_policy.arn
}



### IAM Task Role

resource "aws_iam_role" "url_shortening_task_role" {
  name               = "${var.environment}-url_shortening_task_role"
  description        = "The task role will be assumed by the service in order to invoke other AWS services."
  assume_role_policy = data.aws_iam_policy_document.url_shortener_assume_role_policy.json
}

resource "aws_iam_policy" "url_shortening_task_role_policy" {
  name        = "url_shortening_task_role_policy"
  description = "url_shortening_task_role_policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:*",
        "cloudwatch:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
  }
EOF
}

resource "aws_iam_policy_attachment" "url_shortening_task_role_policy" {
  name       = "url_shortening_task_role_policy-attachment"
  roles      = [aws_iam_role.url_shortening_task_role.name]
  policy_arn = aws_iam_policy.url_shortening_task_role_policy.arn
}
