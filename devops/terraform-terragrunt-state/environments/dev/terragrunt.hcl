# /terraform-terragrunt-state/environments/dev/terragrunt.hcl

# Include the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

# Inputs specific to the dev environment
inputs = {
  file_content = "This is the development environment"
}

# Dynamically generate the backend configuration to use a local state file
generate "backend" {
  path      = "${get_terragrunt_dir()}/backend.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  backend "local" {
    path = "${get_terragrunt_dir()}/terraform.tfstate"
  }
}
EOF
}
