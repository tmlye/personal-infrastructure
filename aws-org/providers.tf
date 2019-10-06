provider "aws" {
  version = "~> 2.31"

  region = "us-east-1"

  shared_credentials_file = "$HOME/.aws/credentials"
  profile                 = "master-terraform"
}
