variable "aws_region" {
  default = "ap-southeast-1"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "cluster_size" {
  default = 3
}

variable "consul_cluster_tag_value" {
    default = "navarro-consul"
}

variable "consul_ami" {
    default = "ami-03f6a11788f8e319e"
}