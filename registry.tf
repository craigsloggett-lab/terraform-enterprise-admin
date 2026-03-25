resource "tfe_registry_provider" "hashicorp" {
  for_each      = toset(["tfe", "aws", "random"])
  name          = each.key
  registry_name = "public"
  namespace     = "hashicorp"
}
