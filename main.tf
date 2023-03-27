resource "aws_instance" "consul_server" {
  count = var.cluster_size

  ami           = var.consul_ami 
  instance_type = var.instance_type
  key_name      = "consulkp_navarro" 
  subnet_id     = aws_subnet.consul_subnet[count.index].id
  vpc_security_group_ids = [aws_security_group.consul_sg.id]
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              echo "export AWS_REGION=${var.aws_region}" >> /etc/environment
              echo "export CONSUL_LOCAL_CONFIG='{ \"datacenter\": \"ap-southeast-1\", \"server\": true }'" >> /etc/environment
              curl -fsSL https://releases.hashicorp.com/consul/1.15.1/consul_1.15.1_linux_amd64.zip -o /tmp/consul.zip
              unzip /tmp/consul.zip -d /usr/local/bin/
              mkdir -p /etc/consul.d
              EOF

  tags = {
    Name = "consul-server-${count.index + 1}"
  }
}



