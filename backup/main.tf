locals {
  common_tags = {
    component = "backup"
  }
}

module "terraform_state" {
  source = "../terraform-modules/aws-terraform-state"

  component           = "backup"
  bucket_name         = var.bucket
  dynamodb_table_name = var.dynamodb_table
}

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

  tags = local.common_tags
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
