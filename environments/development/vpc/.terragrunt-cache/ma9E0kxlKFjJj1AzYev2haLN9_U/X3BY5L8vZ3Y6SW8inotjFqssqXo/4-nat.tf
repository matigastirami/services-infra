// NAT gateway provides internet access to private subnets
// It's recommended to manually allocating static IP addresses as you may need to whitelist it in the future for your clients (Blue greeen deployments may need multiple IP addresses)
resource "aws_eip" "this" {
  vpc = true

  tags = {
    "Name" = "${var.env}-nat"
  }
}

resource "aws_nat_gateway" "this" {
  // It must be place in one of the public subnets with an igw
  subnet_id = aws_subnet.public[0].id
  allocation_id = aws_eip.this.id

  tags = {
    "Name" = "${var.env}-nat"
  }

  // It must explicitly depend on the internet gateway
  depends_on = [aws_internet_gateway.this]
}