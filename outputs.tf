# Each Resource should list it's inputs (which will be available as properties), and "additional attributes" that occur post deployment
output "new_repo_url"{
    value = git_hub_repository.example.html_url
}