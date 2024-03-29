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

variable "cloudflare_api_token" {
  type        = string
  description = "Cloudflare API token"
}

variable "site_domain" {
  type        = string
  description = "Cloudflare Domain/Zone"
}

# S3 Vars
variable "s3_block_public_acls" {
  type        = string
  description = "Block public ACLs"
}

variable "s3_block_public_policy" {
  type        = string
  description = "Block public ACLs plicy"
}

variable "s3_ignore_public_acls" {
  type        = string
  description = "ignore public ACLs"
}

variable "s3_restrict_public_buckets" {
  type        = string
  description = "Restric access to public buckets"
}
