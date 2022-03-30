# Configure the GitHub Provider
provider "github" {
    #token = var.github_token
    #owner = var.org_name
}

module "net-core-example-repo" {
  source = "./modules/repository"
  repository_name = "net-core-example"
  repo_prefix = "communications"
  org_name = var.org_name
}

module "enum-connector" {
  source = "./modules/repository"
  repository_name = "enum-connector"
  repo_prefix = "communications"
  org_name = var.org_name
}


