terraform {
  backend "s3" {
    bucket         = "sumesh-tfstate-us-east-1"
    key            = "infra/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks-sumesh"
    encrypt        = true
  }
}
