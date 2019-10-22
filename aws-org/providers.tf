provider "aws" {
  version = "~> 2.32"
  region  = var.region
  profile = var.profile
}

provider "null" {
  version = "~> 2.1"
}
