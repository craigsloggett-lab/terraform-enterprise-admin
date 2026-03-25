resource "tfe_team" "owners" {
  name = "owners"
}

# Create an admin team to eliminate the need to give owners access to new users.
resource "tfe_team" "admins" {
  name       = "admins"
  visibility = "secret"

  organization_access {
    access_secret_teams        = true
    manage_agent_pools         = true
    manage_membership          = true
    manage_modules             = true
    manage_organization_access = false
    manage_policies            = true
    manage_policy_overrides    = true
    manage_projects            = true
    manage_providers           = true
    manage_run_tasks           = true
    manage_teams               = true
    manage_vcs_settings        = true
    manage_workspaces          = true
    read_projects              = true
    read_workspaces            = true
  }
}

data "tfe_organization_membership" "admins" {
  for_each = var.admins_team_emails
  email    = each.key
}

resource "tfe_team_organization_members" "admins" {
  team_id                     = tfe_team.admins.id
  organization_membership_ids = [for email in var.admins_team_emails : data.tfe_organization_membership.admins[email].id]
}
