resource "aws_internet_gateway" "consul_igw" {
  vpc_id = aws_vpc.consul_vpc.id

  tags = {
    Name = "consul-igw"
  }
}