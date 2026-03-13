module "vpc_example_simple" {
  source  = "terraform-aws-modules/vpc/aws//examples/simple"
  version = "6.6.0"
}

provider "aws" {
  region = local.region
  profile = "joe"
}

data "aws_availability_zones" "available" {}

locals {
  name   = "ex-${basename(path.cwd)}"
  region = "ap-northeast-1"

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = {
    Example    = local.name
    GithubRepo = "terraform-aws-vpc"
    GithubOrg  = "terraform-aws-modules"
  }
}