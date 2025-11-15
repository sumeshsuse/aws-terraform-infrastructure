# Create EC2 Instances

# --- Web EC2 in Public Subnet ---
resource "aws_instance" "web_server" {
  ami                    = var.ec2_ami
  instance_type          = var.ec2_instance_type
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = [var.web_sg_id]

  tags = { Name = "web_server_public" }
}

# --- DB EC2 in Private Subnet ---
resource "aws_instance" "db_server" {
  ami                    = var.ec2_ami
  instance_type          = var.ec2_instance_type
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [var.db_sg_id]

  tags = { Name = "db_server_private" }
}
