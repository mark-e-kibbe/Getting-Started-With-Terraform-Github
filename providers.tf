terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 4.0"
    }
  }
}

# Configure the GitHub Provider
# Setting the GITHUB_TOKEN environment variable allows for authentication as well
provider "github" {
    token = var.github_token
}