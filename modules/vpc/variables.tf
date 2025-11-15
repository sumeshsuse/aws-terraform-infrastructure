variable "vpc_name" {
  type = string
  description = "Initializing the vpc name"
}


variable "vpc_cidr" {
    type = string
    description = "Initializing the VPC CIDR"
  
}


variable "cidr_block_public_subnet_cidr_block" {
   type = string
   description = "public subnet cidr block"
}


variable "cidr_block_private_subnet_cidr_block" {
   type = string
   description = "private subnet cidr block"
}


variable "route_tbl_public_cidr_block" {
  type = string
  description = "route table of the public subnet"  
}

variable "az" {
  type = string
  description = "this is to initialize the availability zone"
}

