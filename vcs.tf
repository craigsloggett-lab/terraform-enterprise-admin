resource "tfe_oauth_client" "github" {
  name                = var.github_organization_name
  api_url             = "https://api.github.com"
  http_url            = "https://github.com"
  oauth_token         = var.github_vcs_provider_oauth_token
  service_provider    = "github"
  organization_scoped = true
}
