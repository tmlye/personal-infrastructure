resource "aws_organizations_policy" "this" {
  name        = "Baseline"
  description = "Allows access to used services"

  content = templatefile("${path.module}/baseline.json", {})
}

resource "aws_organizations_policy_attachment" "this" {
  policy_id = aws_organizations_policy.this.id
  target_id = var.org_root_id
}

