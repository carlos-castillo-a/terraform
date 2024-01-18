# Create bucket(s) via module
module "s3-module" {
  source      = "app.terraform.io/aws-castillo-a/s3-module/aws" # Required
  version     = "1.0.3"                                         # Required
  project     = var.project                                     # Required
  environment = var.environment                                 # Required
  num         = 2                                               # Required

  # name_suffix           = ""                                                                       # Optional
  # block_public_access = true                                                                       # Optional
  # versioning_enabled  = true                                                                       # Optional
  # tags                = {}                                                                         # Optional       
}