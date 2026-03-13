# simple

* Make some example from Terraform VPC module example: simple
    * 1 region 2 az 
        * 1 vpc
        * 2 private subnet
        * 2 public subnet
        * 1 NAT gateway for all private subnet
        * ...etc

## Quick Start

```shell
$ terraform init
$ terraform plan
$ terraform apply
```

## Docs

* [github.com/terraform-aws-modules/terraform-aws-vpc/tree/master/examples/simple](https://github.com/terraform-aws-modules/terraform-aws-vpc/tree/master/examples/simple)
* [hashicorp/aws/latest/docs#authentication-and-configuration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication-and-configuration)