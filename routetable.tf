resource "aws_route_table" "consul_route_table" {
  vpc_id = aws_vpc.consul_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.consul_igw.id
  }

  tags = {
    Name = "consul-route-table"
  }
}

resource "aws_route_table_association" "consul_route_table_association" {
  count = var.cluster_size

  subnet_id      = aws_subnet.consul_subnet[count.index].id
  route_table_id = aws_route_table.consul_route_table.id
}