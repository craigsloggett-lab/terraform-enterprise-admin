resource "tfe_workspace" "terraform_enterprise_admin" {
  name       = "terraform-enterprise-admin"
  project_id = tfe_project.admin.id

  auto_apply            = true
  queue_all_runs        = true
  terraform_version     = var.terraform_version
  file_triggers_enabled = false

  vcs_repo {
    branch         = "main"
    identifier     = "${var.github_organization_name}/terraform-enterprise-admin"
    oauth_token_id = tfe_oauth_client.github.oauth_token_id
  }
}

resource "tfe_variable" "tfe_admin_github_vcs_provider_oauth_token" {
  key          = "github_vcs_provider_oauth_token"
  value        = ""
  sensitive    = true
  category     = "terraform"
  description  = "Set to a Personal Access Token for the service account in the craigsloggett-lab GitHub organization."
  workspace_id = tfe_workspace.terraform_enterprise_admin.id
}

resource "tfe_variable" "tfe_admin_tfe_hostname" {
  key          = "tfe_hostname"
  value        = var.tfe_hostname
  category     = "terraform"
  description  = "The hostname of the Terraform Enterprise instance."
  workspace_id = tfe_workspace.terraform_enterprise_admin.id
}

resource "tfe_variable" "tfe_admin_tfe_organization" {
  key          = "tfe_organization"
  value        = var.tfe_organization
  category     = "terraform"
  description  = "The name of the Terraform Enterprise organization."
  workspace_id = tfe_workspace.terraform_enterprise_admin.id
}

resource "tfe_workspace" "vault_enterprise_deploy" {
  name       = "vault-enterprise-deploy"
  project_id = tfe_project.infrastructure.id

  auto_apply            = true
  queue_all_runs        = true
  terraform_version     = var.terraform_version
  file_triggers_enabled = false

  vcs_repo {
    branch         = "main"
    identifier     = "${var.github_organization_name}/vault-enterprise-deploy"
    oauth_token_id = tfe_oauth_client.github.oauth_token_id
  }
}

data "tfe_variables" "vault_enterprise_deploy" {
  workspace_id = tfe_workspace.vault_enterprise_deploy.id
}

resource "tfe_variable" "vault_deploy_project_name" {
  key          = "project_name"
  value        = "vault"
  category     = "terraform"
  description  = "Name prefix for all resources."
  workspace_id = tfe_workspace.vault_enterprise_deploy.id
}

resource "tfe_variable" "vault_deploy_route53_zone_name" {
  key          = "route53_zone_name"
  value        = "craig-sloggett.sbx.hashidemos.io"
  category     = "terraform"
  description  = "Name of the existing Route 53 hosted zone."
  workspace_id = tfe_workspace.vault_enterprise_deploy.id
}

resource "tfe_variable" "vault_deploy_vault_license" {
  key          = "vault_license"
  value        = ""
  sensitive    = true
  category     = "terraform"
  description  = "Vault Enterprise license string."
  workspace_id = tfe_workspace.vault_enterprise_deploy.id
}

resource "tfe_variable" "vault_deploy_ec2_key_pair_name" {
  key          = "ec2_key_pair_name"
  value        = local.vault_deploy_ec2_key_pair_name
  category     = "terraform"
  description  = "Name of an existing EC2 key pair for SSH access."
  workspace_id = tfe_workspace.vault_enterprise_deploy.id
}

resource "tfe_variable" "vault_deploy_ec2_ami_owner" {
  key          = "ec2_ami_owner"
  value        = "888995627335"
  category     = "terraform"
  description  = "AWS account ID of the AMI owner."
  workspace_id = tfe_workspace.vault_enterprise_deploy.id
}

resource "tfe_variable" "vault_deploy_ec2_ami_name" {
  key          = "ec2_ami_name"
  value        = "hc-base-ubuntu-2404-amd64-*"
  category     = "terraform"
  description  = "Name filter for the AMI (supports wildcards)."
  workspace_id = tfe_workspace.vault_enterprise_deploy.id
}

resource "tfe_variable" "vault_deploy_nlb_internal" {
  key          = "nlb_internal"
  value        = "false"
  hcl          = true
  category     = "terraform"
  description  = "Whether the NLB is internal."
  workspace_id = tfe_workspace.vault_enterprise_deploy.id
}

resource "tfe_variable" "vault_deploy_vault_api_allowed_cidrs" {
  key          = "vault_api_allowed_cidrs"
  value        = "[\"0.0.0.0/0\"]"
  hcl          = true
  category     = "terraform"
  description  = "CIDR blocks allowed to reach the Vault API (port 8200)."
  workspace_id = tfe_workspace.vault_enterprise_deploy.id
}

resource "tfe_workspace" "vault_enterprise_admin" {
  name       = "vault-enterprise-admin"
  project_id = tfe_project.admin.id

  auto_apply            = true
  queue_all_runs        = true
  terraform_version     = var.terraform_version
  file_triggers_enabled = false

  vcs_repo {
    branch         = "main"
    identifier     = "${var.github_organization_name}/vault-enterprise-admin"
    oauth_token_id = tfe_oauth_client.github.oauth_token_id
  }
}

resource "tfe_workspace" "nomad_enterprise_deploy" {
  name       = "nomad-enterprise-deploy"
  project_id = tfe_project.infrastructure.id

  auto_apply            = true
  queue_all_runs        = true
  terraform_version     = var.terraform_version
  file_triggers_enabled = false

  vcs_repo {
    branch         = "main"
    identifier     = "${var.github_organization_name}/nomad-enterprise-deploy"
    oauth_token_id = tfe_oauth_client.github.oauth_token_id
  }
}

data "tfe_variables" "nomad_enterprise_deploy" {
  workspace_id = tfe_workspace.nomad_enterprise_deploy.id
}

resource "tfe_variable" "nomad_deploy_project_name" {
  key          = "project_name"
  value        = "nomad"
  category     = "terraform"
  description  = "Name prefix for all resources."
  workspace_id = tfe_workspace.nomad_enterprise_deploy.id
}

resource "tfe_variable" "nomad_deploy_route53_zone_name" {
  key          = "route53_zone_name"
  value        = "craig-sloggett.sbx.hashidemos.io"
  category     = "terraform"
  description  = "Name of the existing Route 53 hosted zone."
  workspace_id = tfe_workspace.nomad_enterprise_deploy.id
}

resource "tfe_variable" "nomad_deploy_nomad_license" {
  key          = "nomad_license"
  value        = ""
  sensitive    = true
  category     = "terraform"
  description  = "Nomad Enterprise license string."
  workspace_id = tfe_workspace.nomad_enterprise_deploy.id
}

resource "tfe_variable" "nomad_deploy_ec2_key_pair_name" {
  key          = "ec2_key_pair_name"
  value        = local.nomad_deploy_ec2_key_pair_name
  category     = "terraform"
  description  = "Name of an existing EC2 key pair for SSH access."
  workspace_id = tfe_workspace.nomad_enterprise_deploy.id
}

resource "tfe_variable" "nomad_deploy_ec2_ami_owner" {
  key          = "ec2_ami_owner"
  value        = "888995627335"
  category     = "terraform"
  description  = "AWS account ID of the AMI owner."
  workspace_id = tfe_workspace.nomad_enterprise_deploy.id
}

resource "tfe_variable" "nomad_deploy_ec2_ami_name" {
  key          = "ec2_ami_name"
  value        = "hc-base-ubuntu-2404-amd64-*"
  category     = "terraform"
  description  = "Name filter for the AMI (supports wildcards)."
  workspace_id = tfe_workspace.nomad_enterprise_deploy.id
}

resource "tfe_variable" "nomad_deploy_nlb_internal" {
  key          = "nlb_internal"
  value        = "false"
  hcl          = true
  category     = "terraform"
  description  = "Whether the NLB is internal."
  workspace_id = tfe_workspace.nomad_enterprise_deploy.id
}

resource "tfe_variable" "nomad_deploy_nomad_api_allowed_cidrs" {
  key          = "nomad_api_allowed_cidrs"
  value        = "[\"0.0.0.0/0\"]"
  hcl          = true
  category     = "terraform"
  description  = "CIDR blocks allowed to reach the Nomad API (port 4646)."
  workspace_id = tfe_workspace.nomad_enterprise_deploy.id
}

resource "tfe_workspace" "nomad_enterprise_admin" {
  name       = "nomad-enterprise-admin"
  project_id = tfe_project.admin.id

  auto_apply            = true
  queue_all_runs        = true
  terraform_version     = var.terraform_version
  file_triggers_enabled = false

  vcs_repo {
    branch         = "main"
    identifier     = "${var.github_organization_name}/nomad-enterprise-admin"
    oauth_token_id = tfe_oauth_client.github.oauth_token_id
  }
}

resource "tfe_workspace" "consul_enterprise_deploy" {
  name       = "consul-enterprise-deploy"
  project_id = tfe_project.infrastructure.id

  auto_apply            = true
  queue_all_runs        = true
  terraform_version     = var.terraform_version
  file_triggers_enabled = false

  vcs_repo {
    branch         = "main"
    identifier     = "${var.github_organization_name}/consul-enterprise-deploy"
    oauth_token_id = tfe_oauth_client.github.oauth_token_id
  }
}

data "tfe_variables" "consul_enterprise_deploy" {
  workspace_id = tfe_workspace.consul_enterprise_deploy.id
}

resource "tfe_variable" "consul_deploy_project_name" {
  key          = "project_name"
  value        = "consul"
  category     = "terraform"
  description  = "Name prefix for all resources."
  workspace_id = tfe_workspace.consul_enterprise_deploy.id
}

resource "tfe_variable" "consul_deploy_route53_zone_name" {
  key          = "route53_zone_name"
  value        = "craig-sloggett.sbx.hashidemos.io"
  category     = "terraform"
  description  = "Name of the existing Route 53 hosted zone."
  workspace_id = tfe_workspace.consul_enterprise_deploy.id
}

resource "tfe_variable" "consul_deploy_consul_license" {
  key          = "consul_license"
  value        = ""
  sensitive    = true
  category     = "terraform"
  description  = "Consul Enterprise license string."
  workspace_id = tfe_workspace.consul_enterprise_deploy.id
}

resource "tfe_variable" "consul_deploy_ec2_key_pair_name" {
  key          = "ec2_key_pair_name"
  value        = local.consul_deploy_ec2_key_pair_name
  category     = "terraform"
  description  = "Name of an existing EC2 key pair for SSH access."
  workspace_id = tfe_workspace.consul_enterprise_deploy.id
}

resource "tfe_variable" "consul_deploy_ec2_ami_owner" {
  key          = "ec2_ami_owner"
  value        = "888995627335"
  category     = "terraform"
  description  = "AWS account ID of the AMI owner."
  workspace_id = tfe_workspace.consul_enterprise_deploy.id
}

resource "tfe_variable" "consul_deploy_ec2_ami_name" {
  key          = "ec2_ami_name"
  value        = "hc-base-ubuntu-2404-amd64-*"
  category     = "terraform"
  description  = "Name filter for the AMI (supports wildcards)."
  workspace_id = tfe_workspace.consul_enterprise_deploy.id
}

resource "tfe_variable" "consul_deploy_nlb_internal" {
  key          = "nlb_internal"
  value        = "false"
  hcl          = true
  category     = "terraform"
  description  = "Whether the NLB is internal."
  workspace_id = tfe_workspace.consul_enterprise_deploy.id
}

resource "tfe_variable" "consul_deploy_consul_api_allowed_cidrs" {
  key          = "consul_api_allowed_cidrs"
  value        = "[\"0.0.0.0/0\"]"
  hcl          = true
  category     = "terraform"
  description  = "CIDR blocks allowed to reach the Consul API (port 8501)."
  workspace_id = tfe_workspace.consul_enterprise_deploy.id
}

resource "tfe_workspace" "consul_enterprise_admin" {
  name       = "consul-enterprise-admin"
  project_id = tfe_project.admin.id

  auto_apply            = true
  queue_all_runs        = true
  terraform_version     = var.terraform_version
  file_triggers_enabled = false

  vcs_repo {
    branch         = "main"
    identifier     = "${var.github_organization_name}/consul-enterprise-admin"
    oauth_token_id = tfe_oauth_client.github.oauth_token_id
  }
}

resource "tfe_workspace" "pingfederate_deploy" {
  name       = "pingfederate-deploy"
  project_id = tfe_project.infrastructure.id

  auto_apply            = true
  queue_all_runs        = true
  terraform_version     = var.terraform_version
  file_triggers_enabled = false

  vcs_repo {
    branch         = "main"
    identifier     = "${var.github_organization_name}/pingfederate-deploy"
    oauth_token_id = tfe_oauth_client.github.oauth_token_id
  }
}

data "tfe_variables" "pingfederate_deploy" {
  workspace_id = tfe_workspace.pingfederate_deploy.id
}

resource "tfe_variable" "pingfederate_deploy_project_name" {
  key          = "project_name"
  value        = "plugin-dev"
  category     = "terraform"
  description  = "Name prefix for all resources."
  workspace_id = tfe_workspace.pingfederate_deploy.id
}

resource "tfe_variable" "pingfederate_deploy_route53_zone_name" {
  key          = "route53_zone_name"
  value        = "craig-sloggett.sbx.hashidemos.io"
  category     = "terraform"
  description  = "Name of the existing Route 53 hosted zone."
  workspace_id = tfe_workspace.pingfederate_deploy.id
}

resource "tfe_variable" "pingfederate_deploy_vpc_name" {
  key          = "vpc_name"
  value        = "vault"
  category     = "terraform"
  description  = "Name tag of the existing VPC."
  workspace_id = tfe_workspace.pingfederate_deploy.id
}

resource "tfe_variable" "pingfederate_deploy_ec2_key_pair_name" {
  key          = "ec2_key_pair_name"
  value        = local.pingfederate_deploy_ec2_key_pair_name
  category     = "terraform"
  description  = "Name of an existing EC2 key pair for SSH access."
  workspace_id = tfe_workspace.pingfederate_deploy.id
}

resource "tfe_variable" "pingfederate_deploy_ec2_ami_owner" {
  key          = "ec2_ami_owner"
  value        = "888995627335"
  category     = "terraform"
  description  = "AWS account ID of the AMI owner."
  workspace_id = tfe_workspace.pingfederate_deploy.id
}

resource "tfe_variable" "pingfederate_deploy_ec2_ami_name" {
  key          = "ec2_ami_name"
  value        = "hc-base-ubuntu-2404-amd64-*"
  category     = "terraform"
  description  = "Name filter for the AMI (supports wildcards)."
  workspace_id = tfe_workspace.pingfederate_deploy.id
}

resource "tfe_variable" "pingfederate_deploy_pingfederate_allowed_cidrs" {
  key          = "pingfederate_allowed_cidrs"
  value        = "[\"0.0.0.0/0\"]"
  hcl          = true
  category     = "terraform"
  description  = "External CIDR blocks allowed to access PingFederate (ports 9999 and 9031)."
  workspace_id = tfe_workspace.pingfederate_deploy.id
}

resource "tfe_variable" "pingfederate_deploy_pingfederate_zip_path" {
  key          = "pingfederate_zip_path"
  value        = "./pingfederate-13.0.1.zip"
  category     = "terraform"
  description  = "Local path to the PingFederate distribution zip file."
  workspace_id = tfe_workspace.pingfederate_deploy.id
}

resource "tfe_variable" "pingfederate_deploy_pingfederate_license_path" {
  key          = "pingfederate_license_path"
  value        = "./PingFederate-13.0-Development.lic"
  category     = "terraform"
  description  = "Local path to the PingFederate license file."
  workspace_id = tfe_workspace.pingfederate_deploy.id
}

resource "tfe_workspace" "pingfederate_admin" {
  name       = "pingfederate-admin"
  project_id = tfe_project.admin.id

  auto_apply            = true
  queue_all_runs        = true
  terraform_version     = var.terraform_version
  file_triggers_enabled = false

  vcs_repo {
    branch         = "main"
    identifier     = "${var.github_organization_name}/pingfederate-admin"
    oauth_token_id = tfe_oauth_client.github.oauth_token_id
  }
}

resource "tfe_workspace" "github_admin" {
  name       = "github-admin"
  project_id = tfe_project.admin.id

  auto_apply            = true
  queue_all_runs        = true
  terraform_version     = var.terraform_version
  file_triggers_enabled = false

  vcs_repo {
    branch         = "main"
    identifier     = "${var.github_organization_name}/github-admin"
    oauth_token_id = tfe_oauth_client.github.oauth_token_id
  }
}

resource "tfe_workspace" "hashistack_workload_demo" {
  name       = "hashistack-workload-demo"
  project_id = tfe_project.workloads.id

  auto_apply            = true
  queue_all_runs        = true
  terraform_version     = var.terraform_version
  file_triggers_enabled = false

  vcs_repo {
    branch         = "main"
    identifier     = "${var.github_organization_name}/hashistack-workload-demo"
    oauth_token_id = tfe_oauth_client.github.oauth_token_id
  }
}
