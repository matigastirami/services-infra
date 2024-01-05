// When it's the only resource of the type, the convention is calling it this
resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr_block

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    "Name" = "${var.env}-main"
  }
}