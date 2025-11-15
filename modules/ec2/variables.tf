variable "ec2_ami" {
  type = string
  description = "this is to initalize the EC2 AMI"  
}


variable "ec2_instance_type" {
    type = string
    description = "this is to initialize the EC2 instance type"
}

variable "public_subnet_id"  { 
  type = string 
}


variable "private_subnet_id" { 
 type = string 
}

variable "web_sg_id"         { 
 type = string 
}


variable "db_sg_id"          { 
  type = string 
  }