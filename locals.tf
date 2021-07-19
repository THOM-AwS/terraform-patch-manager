locals {
  enabled     = true
  env = {
    sandpit = {
      aws_profile = "cmdlab-sandpit1"
      aws_region  = "ap-southeast-2"
    }
  }
  workspace = local.env[terraform.workspace]
}
