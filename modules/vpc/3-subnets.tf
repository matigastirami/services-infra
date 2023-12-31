resource "aws_subnet" "private" {
  vpc_id = aws_vpc.this.id
  count = length(var.private_subnets)
  cidr_block = var.private_subnets[count.index]
  availability_zone = var.azs[count.index]
  tags = merge(
    { Name = "${var.env}-private-${var.azs[count.index]}" },
    var.private_subnet_tags
  )
}

resource "aws_subnet" "public" {
  vpc_id = aws_vpc.this.id
  count = length(var.public_subnets)
  cidr_block = var.public_subnets[count.index]
  availability_zone = var.azs[count.index]
  map_public_ip_on_launch = true
  tags = merge(
    { Name = "${var.env}-public-${var.azs[count.index]}" },
    var.public_subnet_tags
  )
}