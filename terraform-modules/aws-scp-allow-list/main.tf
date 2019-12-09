resource "aws_organizations_policy" "this" {
  name        = "AllowList"
  description = "Allows access to used services"

  content = templatefile("${path.module}/allow-list.json", {})
}
