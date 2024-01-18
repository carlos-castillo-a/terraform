# Configure Terraform Cloud & Required Providers
terraform {
  cloud {
    organization = var.organization

    workspaces {
      tags = [var.environment]
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
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
      IaC         = "terraform"
      Project     = var.project
    }
  }
}

# Configure the Cloudflare provider
provider "cloudflare" {
  api_token = var.cloudflare_api_token
}