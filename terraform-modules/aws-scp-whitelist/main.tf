resource "aws_organizations_policy" "this" {
  name        = "Baseline"
  description = "Allows access to used services"

  content = templatefile("${path.module}/baseline.json", {})
}
