data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "this" {
  bucket = "duplicity-backup-j7v3a"
  acl    = "private"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    id      = "expire"
    enabled = true

    noncurrent_version_expiration {
      days = 30
    }
  }

  lifecycle_rule {
    id      = "transition"
    enabled = true

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    component = "backup"
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id
  policy = data.aws_iam_policy_document.this.json
}

data "aws_iam_policy_document" "this" {
  statement {
    actions = ["s3:*"]
    effect  = "Allow"

    principals {
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/UploadBackup"]
      type        = "AWS"
    }

    sid = "AllowBackupUser"

    resources = [
      "arn:aws:s3:::${aws_s3_bucket.this.id}",
      "arn:aws:s3:::${aws_s3_bucket.this.id}/*",
    ]
  }

  statement {
    sid    = "DenyUnSecureCommunications"
    effect = "Deny"

    principals {
      identifiers = ["*"]
      type        = "*"
    }

    actions   = ["s3:*"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.this.id}/*"]

    condition {
      test     = "Bool"
      values   = ["false"]
      variable = "aws:SecureTransport"
    }
  }
}
