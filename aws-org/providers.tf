provider "aws" {
  version = "~> 2.31"
  region  = var.region
  profile = var.profile
}

provider "null" {
  version = "~> 2.1"
}
