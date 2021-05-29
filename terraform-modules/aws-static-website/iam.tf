resource "aws_iam_user" "this" {
  name = "${var.component}${var.environment}DeployUser"

  tags = local.common_tags
}

resource "aws_iam_access_key" "this" {
  user    = aws_iam_user.this.name
  pgp_key = "keybase:${var.keybase_username}"
}

resource "aws_iam_user_policy" "this" {
  name = "${var.component}S3AccessPolicy"
  user = aws_iam_user.this.name

  policy = data.aws_iam_policy_document.deploy_user.json
}

data "aws_iam_policy_document" "deploy_user" {
  statement {
    sid = "AllowSeeingBuckets"

    actions = [
      "s3:ListAllMyBuckets",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    sid = "AllowListBucket"

    actions = [
      "s3:ListBucket",
      "s3:GetBucketLocation",
    ]

    resources = [
      "arn:aws:s3:::${aws_s3_bucket.this.id}",
    ]
  }

  statement {
    actions = [
      "s3:PutObject",
    ]

    resources = [
      "arn:aws:s3:::${aws_s3_bucket.this.id}/*",
    ]
  }
}
