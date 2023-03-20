output "consul_servers_public_ips" {
  value = aws_instance.consul_server.*.public_ip
}