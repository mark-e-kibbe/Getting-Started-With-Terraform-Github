# Locals are local variables, they can transform inputs, strip/run terraform functions, etc
locals {
    concatenated_description = "codebase"
}

resource "github_repository" "example" {
  name        = "Example Terraform Repo"
  description = "My awesome ${local.concatenated_description}"
  visibility = var.visibility
}