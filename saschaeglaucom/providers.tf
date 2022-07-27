provider "aws" {
  region  = var.region
  profile = var.profile
}

provider "aws" {
  alias   = "us-east-1"
  region  = "us-east-1"
  profile = var.profile
}
