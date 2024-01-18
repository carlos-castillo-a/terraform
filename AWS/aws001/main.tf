# Configure Terraform Cloud & Required Providers
terraform {
  required_providers {
    spacelift = {
      source = "spacelift-io/spacelift"
    }
  }
}

# Configure Spacelift Provided
provider spacelift {}

# Configure the AWS Provider
provider "aws" {
  region     = "us-east-1"
  # access_key = var.AWS_ACCESS_KEY
  # secret_key = var.AWS_SECRET_KEY

  default_tags {
    tags = {
      Stakeholder = var.stakeholder
      IaC         = "terraform"
      Project     = var.project
    }
  }
}
