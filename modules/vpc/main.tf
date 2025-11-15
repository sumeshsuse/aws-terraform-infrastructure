
# create VPC 
resource "aws_vpc" "main_sumesh_vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = var.vpc_name
  }
}

# Create Subnets

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.main_sumesh_vpc.id
  cidr_block = var.cidr_block_public_subnet_cidr_block
  map_public_ip_on_launch = true
  availability_zone = var.az
  tags = {
    Name = "public_subnet_${var.vpc_name}"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.main_sumesh_vpc.id
  cidr_block = var.cidr_block_private_subnet_cidr_block
  availability_zone = var.az
  tags = {
    Name = "private_subnet_${var.vpc_name}"
  }
}

# Create Internet Gateway

resource "aws_internet_gateway" "gw_sumesh" {
  vpc_id = aws_vpc.main_sumesh_vpc.id

  tags = {
    Name = "gw_${var.vpc_name}"
  }
}

# Create Route Tables

resource "aws_route_table" "route_tbl_public" {
  vpc_id = aws_vpc.main_sumesh_vpc.id

  route {
    cidr_block = var.route_tbl_public_cidr_block
    gateway_id = aws_internet_gateway.gw_sumesh.id
  }
  tags = {
    Name = "rt_tbl_public_${var.vpc_name}"
  }
}



resource "aws_route_table" "route_tbl_private" {
  vpc_id = aws_vpc.main_sumesh_vpc.id
  tags = {
    Name = "rt_tbl_private_${var.vpc_name}"
  }
}

resource "aws_route_table_association" "route_tbl_association_public" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.route_tbl_public.id
}

resource "aws_route_table_association" "route_tbl_association_private" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.route_tbl_private.id
}


# Create Security Groups - web public

resource "aws_security_group" "allow_web" {
  name        = "allow_web"
  description = "Allow HTTP and SSH"
  vpc_id      = aws_vpc.main_sumesh_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

   tags = { Name = "allow_web_${var.vpc_name}" }
}

# Security Group - DB private 
resource "aws_security_group" "allow_db" {
  name        = "allow_db"
  description = "Allow DB traffic only from web tier"
  vpc_id      = aws_vpc.main_sumesh_vpc.id

  ingress {
    description     = "MySQL from Web SG"
    from_port       = 3306             
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.allow_web.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "allow_db_${var.vpc_name}" }
}
