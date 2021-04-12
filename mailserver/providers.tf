provider "aws" {
  version = "~> 3.36"
  region  = var.region
  profile = var.profile
}

provider "random" {
  version = "~> 2.2"
}
