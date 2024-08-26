terraform {
  source = "../modules/kind"
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


inputs = {
  cluster_name = "kindcluster"
}
