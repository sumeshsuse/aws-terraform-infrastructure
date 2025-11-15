module "vpc" {
  source = "./modules/vpc"

  vpc_name = var.vpc_name
  vpc_cidr = var.vpc_cidr

  cidr_block_public_subnet_cidr_block  = var.public_subnet_cidr
  cidr_block_private_subnet_cidr_block = var.private_subnet_cidr

  route_tbl_public_cidr_block = var.public_route_cidr
  az                          = var.az
}

module "ec2" {
  source            = "./modules/ec2"
  ec2_instance_type = var.ec2_instance_type
  ec2_ami           = data.aws_ssm_parameter.al2023.value
  public_subnet_id  = module.vpc.public_subnet_id
  private_subnet_id = module.vpc.private_subnet_id
  web_sg_id         = module.vpc.web_sg_id
  db_sg_id          = module.vpc.db_sg_id
}
