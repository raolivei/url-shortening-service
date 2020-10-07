resource "aws_iam_role" "url_shortening_role" {
  name               = "url_shortening_role"
  assume_role_policy = data.aws_iam_policy_document.url_shortener_assume_role_policy.json
}

data "aws_iam_policy_document" "url_shortener_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs.amazonaws.com"]
    }
  }
}