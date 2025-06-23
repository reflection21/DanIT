locals {
  deployment_prefix = "artem"
  aws_region        = "eu-north-1"
  default_tags = {
    "TerminationDate"  = "Permanent",
    "Environment"      = "Test",
    "Team"             = "DevOps",
    "DeployedBy"       = "Terraform",
    "OwnerEmail"       = "artembrigaz@gmail.com"
    "DeploymentPrefix" = local.deployment_prefix
  }
}
# Configure Terragrunt to automatically store tfstate files in an S3 bucket
remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket         = "terraform-state-danit-devops-8-artem"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "eu-north-1"
    encrypt        = true
    s3_bucket_tags = local.default_tags
    use_lockfile   = true
  }
}

# Generate an AWS provider block
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region = var.aws_region
  default_tags {
    tags = var.default_tags
  }
}

variable "aws_region" {
  description = "AWS Region."
}

variable "default_tags" {
  type        = map(string)
  description = "Default tags for AWS that will be attached to each resource."
}
EOF
}

retryable_errors = [
  "(?s).*Error.*Required plugins are not installed.*"
]

inputs = {
  aws_region        = local.aws_region
  deployment_prefix = local.deployment_prefix
  default_tags      = local.default_tags
}
