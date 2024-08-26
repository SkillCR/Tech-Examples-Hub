terraform {
  source = "../../modules/helm"
}

generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  backend "local" {
    path = "./terraform.tfstate"
  }
}
EOF
}

inputs = {
  namespace_name = "stage"
}
