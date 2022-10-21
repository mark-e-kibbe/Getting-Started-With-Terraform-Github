# Locals are local variables, they can transform inputs, strip/run terraform functions, etc
locals {
    concatenated_description = "codebase"
}

resource "github_repository" "example" {
  name        = "ExampleTerraformRepo"
  description = "${var.description_prefix} ${local.concatenated_description}"
  visibility = var.visibility
}