locals {
  role_name = "assumedFromMaster"
}

resource "aws_organizations_account" "this" {
  name  = var.name
  email = var.email

  role_name = local.role_name

  # There is no AWS Organizations API for reading role_name
  lifecycle {
    ignore_changes = [role_name]
  }
}

resource "aws_iam_account_alias" "this" {
  provider = aws.new_account

  account_alias = var.name
}

resource "aws_s3_bucket" "this" {
  provider = aws.new_account

  bucket = "${var.name}-tf-state-${random_string.this.result}"
  acl    = "private"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    id      = "expire"
    enabled = true

    noncurrent_version_expiration {
      days = 90
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  provider = aws.new_account

  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "this" {
  provider = aws.new_account

  name         = "${var.name}-tf-state-${random_string.this.result}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "random_string" "this" {
  length  = 4
  upper   = false
  special = false
}
