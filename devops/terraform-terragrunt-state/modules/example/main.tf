# /terraform-terragrunt-state/modules/example/main.tf

# The local_file resource creates a file with content specified in the variable 'file_content'
resource "local_file" "example" {
  content  = var.file_content
  filename = "${path.module}/output.txt"
}

# Output the path of the created file
output "file_path" {
  value = local_file.example.filename
}

variable "file_content" {
  type = string
}
