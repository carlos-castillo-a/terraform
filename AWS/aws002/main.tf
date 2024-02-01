# Configure Terraform Cloud & Required Providers
terraform {
  cloud {
    organization = var.organization

    workspaces {
      tags = [var.envrionment]
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region     = "us-east-1"
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY

  default_tags {
    tags = {
      Stakeholder = var.stakeholder
      IaC         = "terraform-cloud"
      Project     = var.project
    }
  }
}
