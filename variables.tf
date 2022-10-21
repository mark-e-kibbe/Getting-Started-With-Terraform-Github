variable "github_token" {
    type = string
    sensitive = true
    description = "Personal Access Token on Github. To create, follow: https://docs.github.com/en/enterprise-server@3.4/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token"
}

variable "visibility" {
    type = string
    description = "Visibility of the repo, private and public are only acceptable values"

    # Validation can be used for variables, the condition is what you want for validity
    validation {
    condition     = contains(["private", "public"], var.visibility)
    error_message = "Visibility must be private or public"
  }
}