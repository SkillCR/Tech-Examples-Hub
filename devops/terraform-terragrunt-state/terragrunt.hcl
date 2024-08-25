# /terraform-terragrunt-state/terragrunt.hcl

# Define where the Terraform module is located
terraform {
  source = "${get_terragrunt_dir()}/../../modules/example"
}
