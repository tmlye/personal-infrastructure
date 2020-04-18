module "website" {
  source = "../terraform-modules/aws-static-website"

  domain_name = "saschaeglau.com"
  component   = "saschaeglaucom"
  environment = "prod"
}
