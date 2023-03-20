resource "aws_vpc" "consul_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "consul-vpc"
  }
}

resource "aws_subnet" "consul_subnet" {
  count = var.cluster_size

  cidr_block = "10.0.${count.index}.0/24"
  vpc_id     = aws_vpc.consul_vpc.id

  tags = {
    Name = "consul-subnet-${count.index}"
  }
}