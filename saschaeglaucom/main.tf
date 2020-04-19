module "website" {
  source = "../terraform-modules/aws-static-website"

  domain_name = "saschaeglau.com"
  component   = "saschaeglaucom"
  environment = "prod"

  providers = {
    aws           = aws
    aws.us-east-1 = aws.us-east-1
  }
}
