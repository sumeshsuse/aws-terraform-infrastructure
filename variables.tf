variable "vpc_name" { type = string }
variable "vpc_cidr" { type = string }

variable "public_subnet_cidr" { type = string }
variable "private_subnet_cidr" { type = string }

variable "public_route_cidr" { type = string } # usually "0.0.0.0/0"
variable "az" { type = string }

variable "ec2_instance_type" { type = string }

variable "region" {
  type        = string
  description = "AWS region for the provider"
}

