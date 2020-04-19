provider "aws" {
  version = "~> 2.31"
  region  = var.region
  profile = var.profile
}

provider "aws" {
  alias   = "us-east-1"
  version = "~> 2.31"
  region  = "us-east-1"
  profile = var.profile
}

provider "random" {
  version = "~> 2.2"
}
