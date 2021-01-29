terraform {
  required_providers {
    aws = {
      version = "2.33.0"
      source = "hashicorp/aws"
    }
    random = {
      version = "2.2"
      source = "hashicorp/random"
    }
  }
}

provider "aws" {
  region = var.aws_region
}



module "website_s3_bucket" {
  source = "github.com/binh-le-thanh-mox/tfc-test-1/vpc"

  bucket_name = "tfc-test-bucket"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "random_pet" "table_name" {}

resource "aws_dynamodb_table" "tfc_example_table" {
  name = "${var.db_table_name}-${random_pet.table_name.id}"

  read_capacity  = var.db_read_capacity
  write_capacity = var.db_write_capacity
  hash_key       = "UUID"

  attribute {
    name = "UUID"
    type = "S"
  }
}
