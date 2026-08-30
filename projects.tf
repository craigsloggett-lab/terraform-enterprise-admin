resource "tfe_project" "default" {
  name        = "Default Project"
  description = "The default project for new workspaces."
}

# Provide the 'admins' team admin access to the 'Default Project' project.
resource "tfe_team_project_access" "admins_default_project" {
  access     = "admin"
  team_id    = tfe_team.admins.id
  project_id = tfe_project.default.id
}

resource "tfe_project" "admin" {
  name        = "Administration"
  description = "A collection of workspaces to manage the platform."
}

# Provide the 'admins' team admin access to the 'Administration' project.
resource "tfe_team_project_access" "admins_administration" {
  access     = "admin"
  team_id    = tfe_team.admins.id
  project_id = tfe_project.admin.id
}

resource "tfe_project" "modules" {
  name        = "Modules"
  description = "A collection of workspaces to test modules."
}

resource "tfe_project" "stacks" {
  name        = "Stacks"
  description = "A collection of stacks."
}

resource "tfe_project" "infrastructure" {
  name        = "Infrastructure"
  description = "A collection of workspaces to deploy infrastructure."
}

# Provide the 'admins' team admin access to the 'Infrastructure' project.
resource "tfe_team_project_access" "admins_infrastructure" {
  access     = "admin"
  team_id    = tfe_team.admins.id
  project_id = tfe_project.infrastructure.id
}

resource "tfe_project" "workloads" {
  name        = "Workloads"
  description = "A collection of workspaces to deploy application workloads."
}

# Provide the 'admins' team admin access to the 'Workloads' project.
resource "tfe_team_project_access" "admins_workloads" {
  access     = "admin"
  team_id    = tfe_team.admins.id
  project_id = tfe_project.workloads.id
}
