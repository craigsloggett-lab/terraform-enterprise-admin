resource "tfe_variable_set" "tfe_provider_authentication" {
  name        = "TFE Provider Authentication"
  description = "The token used to authenticate the TFE provider for managing this Terraform Enterprise instance."
}

resource "tfe_variable" "tfe_token" {
  key             = "TFE_TOKEN"
  value           = ""
  sensitive       = true
  category        = "env"
  description     = "Set to a Team Token for the \"owners\" team."
  variable_set_id = tfe_variable_set.tfe_provider_authentication.id
}

resource "tfe_workspace_variable_set" "tfe_provider_authentication_terraform_enterprise_admin" {
  variable_set_id = tfe_variable_set.tfe_provider_authentication.id
  workspace_id    = tfe_workspace.terraform_enterprise_admin.id
}

resource "tfe_variable_set" "aws_provider_authentication" {
  for_each    = var.application_environments
  name        = "AWS Provider Authentication (${title(each.key)})"
  description = "The access key and secret access key IDs used to authenticate the AWS provider for the ${each.key} environment."
  global      = false
}

resource "tfe_project_variable_set" "aws_provider_authentication_dev_infrastructure" {
  variable_set_id = tfe_variable_set.aws_provider_authentication["development"].id
  project_id      = tfe_project.infrastructure.id
}

# This data source is used to get the values of non-sensitive variables since
# they are expected to be updated outside of Terraform and will cause drift
# otherwise.
data "tfe_variables" "aws_provider_authentication" {
  for_each        = var.application_environments
  variable_set_id = tfe_variable_set.aws_provider_authentication[each.key].id
}

resource "tfe_variable" "aws_access_key_id" {
  for_each        = var.application_environments
  key             = "AWS_ACCESS_KEY_ID"
  value           = local.aws_access_key_id_value[each.key]
  category        = "env"
  description     = "AWS Access Key ID"
  variable_set_id = tfe_variable_set.aws_provider_authentication[each.key].id
}

resource "tfe_variable" "aws_secret_access_key" {
  for_each        = var.application_environments
  key             = "AWS_SECRET_ACCESS_KEY"
  value           = "" # An empty value for a sensitive variable will never drift.
  sensitive       = true
  category        = "env"
  description     = "AWS Secret Access Key"
  variable_set_id = tfe_variable_set.aws_provider_authentication[each.key].id
}

resource "tfe_variable" "aws_session_expiration" {
  for_each        = var.application_environments
  key             = "AWS_SESSION_EXPIRATION"
  value           = local.aws_session_expiration_value[each.key]
  category        = "env"
  description     = "AWS Session Expiration"
  variable_set_id = tfe_variable_set.aws_provider_authentication[each.key].id
}

resource "tfe_variable" "aws_session_token" {
  for_each        = var.application_environments
  key             = "AWS_SESSION_TOKEN"
  value           = "" # An empty value for a sensitive variable will never drift.
  sensitive       = true
  category        = "env"
  description     = "AWS Session Token"
  variable_set_id = tfe_variable_set.aws_provider_authentication[each.key].id
}

resource "tfe_variable_set" "github_provider_authentication" {
  name        = "GitHub Provider Authentication"
  description = "The token used to authenticate the GitHub provider for managing the GitHub organization."
}

resource "tfe_variable" "github_token" {
  key             = "GITHUB_TOKEN"
  value           = ""
  sensitive       = true
  category        = "env"
  description     = "Set to a Personal Access Token for a GitHub organization administrator."
  variable_set_id = tfe_variable_set.github_provider_authentication.id
}

resource "tfe_variable" "github_owner" {
  key             = "GITHUB_OWNER"
  value           = "craigsloggett-lab"
  category        = "env"
  description     = "Set to the name of the GitHub organization being managed."
  variable_set_id = tfe_variable_set.github_provider_authentication.id
}
