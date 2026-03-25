resource "tfe_organization" "this" {
  name  = var.tfe_organization
  email = "craig.sloggett@hashicorp.com"

  assessments_enforced = true
}
