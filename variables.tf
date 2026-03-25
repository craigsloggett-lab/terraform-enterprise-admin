variable "tfe_hostname" {
  type        = string
  description = "The hostname of the Terraform Enterprise instance."
}

variable "tfe_organization" {
  type        = string
  description = "The name of the Terraform Enterprise organization."
}

variable "terraform_version" {
  type        = string
  description = "The version of Terraform to use in all workspaces."
  default     = "1.14.7"
}

variable "admins_team_emails" {
  type        = set(string)
  description = "A list of member email addresses for the admins team."
  default     = ["craig.sloggett@hashicorp.com"]
}

variable "github_organization_name" {
  type        = string
  description = "The name of the GitHub organization used to configure the VCS provider."
  default     = "craigsloggett-lab"
}

variable "github_vcs_provider_oauth_token" {
  type        = string
  description = "The personal access token for a service account in the GitHub organization being connected."
  sensitive   = true
}

variable "application_environments" {
  type        = set(string)
  description = "A set of environments that applications will be deploying to."
  default     = ["development", "production"]
}
