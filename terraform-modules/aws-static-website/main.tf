locals {
  s3_origin_id = "${var.component}-${var.environment}"

  common_tags = {
    component   = var.component
    environment = var.environment
  }
}
