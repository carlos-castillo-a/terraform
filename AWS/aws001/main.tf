# Configure Terraform Cloud & Required Providers
terraform {
  required_providers {
    spacelift = {
      source = "spacelift-io/spacelift"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure Spacelift Provided
provider "spacelift" {}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  # access_key = var.AWS_ACCESS_KEY_ID
  # secret_key = var.AWS_SECRET_ACCESS_KEY

  default_tags {
    tags = {
      Stakeholder = var.stakeholder
      IaC         = "terraform"
      Spacelift = "true"
      Project     = var.project
    }
  }
}
