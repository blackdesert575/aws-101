# simple

* Make some example from Terraform VPC module example: simple
    * 1 region 3 az 
        * 1 vpc
        * 3 private subnet
        * 3 public subnet
        * 1 NAT gateway for all private subnet
        * ...etc

## Quick Start

```shell
$ terraform init
$ terraform plan
$ terraform apply
```

## Docs

* 一些參考的文件，跟使用範例

* [github.com/terraform-aws-modules/terraform-aws-vpc/tree/master/examples/simple](https://github.com/terraform-aws-modules/terraform-aws-vpc/tree/master/examples/simple)
* [hashicorp/aws/latest/docs#authentication-and-configuration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication-and-configuration)