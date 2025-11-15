output "vpc_id" {
  description = "the id value of the vpc."
  value = aws_vpc.main_sumesh_vpc
}


output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}


output "private_subnet_id" {
  value = aws_subnet.private_subnet.id
}

output "web_sg_id" { 
  value = aws_security_group.allow_web.id 
}


output "db_sg_id"  { 
  value = aws_security_group.allow_db.id
}