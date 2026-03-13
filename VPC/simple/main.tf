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

  private_azs = slice(local.azs, 0, 1)
  public_azs  = slice(local.azs, 2, 3)

  subnet_pool = cidrsubnets(local.vpc_cidr, 4, 4, 4, 4)

  tags = {
    Example    = local.name
    GithubRepo = "terraform-aws-vpc"
    GithubOrg  = "terraform-aws-modules"
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.6.0"

  name = local.name
  cidr = local.vpc_cidr

  azs             = local.azs
  private_subnets = slice(local.subnet_pool, 0, 2)
  public_subnets  = slice(local.subnet_pool, 2, 4)

  single_nat_gateway = true
  tags = local.tags
}