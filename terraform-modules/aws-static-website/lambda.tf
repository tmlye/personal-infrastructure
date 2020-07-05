locals {
  redirect_lambda_name = "${var.component}-redirect-to-index-${var.environment}"
}

resource "aws_lambda_function" "redirect" {
  provider = aws.us-east-1

  function_name = local.redirect_lambda_name
  handler       = "index.handler"
  runtime       = "nodejs10.x"
  publish       = true
  role          = aws_iam_role.lambda.arn
  filename      = data.archive_file.redirect_zip.output_path
  depends_on    = [aws_iam_role_policy_attachment.lambda_logs, aws_cloudwatch_log_group.redirect]
}

resource "aws_iam_role" "lambda" {
  name = "${var.component}LambdaRole"

  assume_role_policy = data.aws_iam_policy_document.assume_role_lambda.json
}

resource "aws_iam_policy" "lambda" {
  name   = "${var.component}LambdaPolicy"
  policy = data.aws_iam_policy_document.lambda_logging.json
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.lambda.name
  policy_arn = aws_iam_policy.lambda.arn
}

# By default, logs are kept forever
# We use this to reduce the retention period
resource "aws_cloudwatch_log_group" "redirect" {
  name              = "/aws/lambda/${local.redirect_lambda_name}"
  retention_in_days = 1
}

data "aws_iam_policy_document" "assume_role_lambda" {
  version = "2012-10-17"

  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"

      identifiers = [
        "edgelambda.amazonaws.com",
        "lambda.amazonaws.com"
      ]
    }
  }
}

data "aws_iam_policy_document" "lambda_logging" {
  version = "2012-10-17"

  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]

    resources = ["arn:aws:logs:*:*:*"]
  }
}

data "template_file" "redirect" {
  template = file("${path.module}/lambdas/redirect.js")
}

data "archive_file" "redirect_zip" {
  type        = "zip"
  output_path = "${path.module}/redirect.zip"

  source {
    content  = data.template_file.redirect.rendered
    filename = "index.js"
  }
}
