module "scps" {
  source = "../terraform-modules/aws-service-control-policies"

  org_root_id = aws_organizations_organization.org.roots.0.id
}
