# Authentication (use Terraform Cloud Variables)
variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

# Global Vars
variable "project" {
  type        = string
  description = "Project ID"
}

variable "environment" {
  type        = string
  description = "Environment variable"
}

variable "stakeholder" {
  type        = string
  description = "Creator of resources"
}

variable "organization" {
  type        = string
  description = "Terraform Cloud organization"
}

# VPC Variables
variable "VPC_CIDR" {
  default = "10.1.0.0/16"
}

# Public Subnets
variable "PUB_SUB_1_A_CIDR" {
  default = "10.1.0.0/24"
}

variable "PUB_SUB_2_B_CIDR" {
  default = "10.1.1.0/24"
}

# Private Subnets
variable "PRI_SUB_3_A_CIDR" {
  default = "10.1.2.0/24"
}

variable "PRI_SUB_4_B_CIDR" {
  default = "10.1.3.0/24"
}

variable "PRI_SUB_5_A_CIDR" {
  default = "10.1.4.0/24"
}

variable "PRI_SUB_6_B_CIDR" {
  default = "10.1.5.0/24"
}

# Cloudfron Variables
variable "certificate_domain_name" {}
variable "additional_domain_name" {}
variable "record_name" {}

# ASG Variables
variable "AMI" {}