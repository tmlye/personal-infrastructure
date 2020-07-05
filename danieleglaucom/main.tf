module "website" {
  source = "../terraform-modules/aws-static-website"

  domain_name = "danieleglau.com"
  component   = "danieleglaucom"
  environment = "prod"

  keybase_username = "seg"

  providers = {
    aws           = aws
    aws.us-east-1 = aws.us-east-1
  }
}
