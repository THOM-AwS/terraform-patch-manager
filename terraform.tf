terraform {
  # backend "s3" {}

  required_providers {
    aws = {
      version = "3.46.0"
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  profile = local.workspace["aws_profile"]
  region  = local.workspace["aws_region"]
}
