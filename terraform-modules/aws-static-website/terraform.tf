terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.75"
      # ACM certificates for cloudfront need to be created in us-east-1
      configuration_aliases = [ aws.us-east-1 ]
    }
  }
}
