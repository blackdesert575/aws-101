provider "aws" {
  region = local.region
  #根據使用者調整對應的AWS IAM User Profile
  #參考:https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication-and-configuration
  profile = "joe"
}

locals {
  name   = "ex-${basename(path.cwd)}"
  #選一個AWS Region
  #這邊先以東京為例
  region = "ap-northeast-1"

  #這邊要設定一個VPC CIDR
  #需要考慮清楚未來系統的擴充性
  #實務上會先做一個比較大的CIDR範圍
  #但如果確定沒有要放置那麼多機器(IP)
  #則可以不用這麼大的範圍
  #以及VPC CIDR設計還有這個參考文件可以作為IP Range要怎麼設計的一些依據:
  # src: https://datatracker.ietf.org/doc/html/rfc1918#section-3
  vpc_cidr = "10.0.0.0/16"

  #因為上述是用東京這個Region
  #因此我們這邊要使用這個Region底下可以用的AZ
  #文件參考: https://docs.aws.amazon.com/global-infrastructure/latest/regions/aws-availability-zones.html
  azs      = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]

  #這邊是規劃
  #private 私有網段，基於安全的考量基本上不會讓這些網段的機器或服務有對外連網的能力，但考慮到系統建置初期或系統維護時仍有訪問外部網路的需求，因此底下多加了一個
  #single_nat_gateway的配置方便達成前述的需求(系統建置初期或系統維護)，這個部分，可以根據實務場景進行調整，依照需求使用或者用其他方式(也可以在Public subnet自建Nat instance)實作  
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

  #public
  #顧名思義，就是讓這邊的機器或服務透過 internet gateway獲得與外部網路連線的能力
  #詳情:https://docs.aws.amazon.com/vpc/latest/userguide/configure-subnets.html
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  #這邊的配置，加的標籤，主要是為了以後管理或者更進一步的自動化流程(可與Ansible或其他工具/服務(Consul,Prometheus, Cloudwatch...etc)結合使用)預留的設計，
  #方便檢索你需要維護的AWS資源
  tags = {
    Example    = local.name
    GithubRepo = "terraform-aws-vpc"
    GithubOrg  = "terraform-aws-modules"
  }
}

#這邊採用社群共同維護的Terraform AWS VPC module來方便建置VPC
#後續為了多人共同操作的目的
#我們還需要將Terraform做一些重構成
#預計引入Terragrunt以及一些其他搭配的服務達成GitOps的流程
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.6.0"

  name = local.name
  cidr = local.vpc_cidr

  azs             = local.azs
  private_subnets = local.private_subnets
  public_subnets  = local.public_subnets

  single_nat_gateway = true
  tags = local.tags
}