provider "aws" {
  version = "~> 2.31"
  region  = var.region
  profile = var.profile
}

provider "random" {
  version = "~> 2.2"
}
