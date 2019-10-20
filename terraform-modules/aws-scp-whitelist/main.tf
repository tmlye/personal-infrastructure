resource "aws_organizations_policy" "this" {
  name        = "Baseline"
  description = "Allows access to used services"

  content = templatefile("${path.module}/baseline.json", {})
}

resource "aws_organizations_policy_attachment" "this" {
  policy_id = aws_organizations_policy.this.id
  target_id = var.target_id
}

# We use a null resource to remove the FullAWSAccess policy
# which is attached to each account by default
resource "null_resource" "remove_fullaccess" {
  depends_on = [aws_organizations_policy_attachment.this]

  provisioner "local-exec" {
    command = templatefile("${path.module}/remove-fullaccess-policy.sh", { target_id = var.target_id, profile = var.aws_profile })
  }
}
