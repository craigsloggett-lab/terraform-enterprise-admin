locals {
  # The non-sensitive variables in the AWS Provider Authentication variable set
  # will always drift since they are updated dynamically out of band. This
  # local variable is meant to be used as a way to get the values as configured
  # and then use those as the values defined in the `tfe_variable` resource
  # blocks.
  aws_provider_authentication = {
    for environment, variable_set in data.tfe_variables.aws_provider_authentication :
    environment => {
      for variable in variable_set.env :
      variable.name => variable.value
      if !variable.sensitive
    }
  }

  # Lookup the required variable explicitly, handling the case
  # when the variable set hasn't been created yet.
  aws_access_key_id_value = {
    for environment, variable in local.aws_provider_authentication :
    environment => lookup(variable, "AWS_ACCESS_KEY_ID", null)
  }

  # Lookup the required variable explicitly, handling the case
  # when the variable set hasn't been created yet.
  aws_session_expiration_value = {
    for environment, variable in local.aws_provider_authentication :
    environment => lookup(variable, "AWS_SESSION_EXPIRATION", null)
  }

  # Read non-sensitive workspace variables to avoid hardcoding values
  # that should be set out of band.
  vault_enterprise_deploy = {
    for variable in data.tfe_variables.vault_enterprise_deploy.terraform :
    variable.name => variable.value
    if !variable.sensitive
  }

  # Lookup the required variable explicitly, handling the case
  # when the workspace hasn't been created yet.
  vault_deploy_ec2_key_pair_name = lookup(local.vault_enterprise_deploy, "ec2_key_pair_name", null)

  # Read non-sensitive workspace variables to avoid hardcoding values
  # that should be set out of band.
  nomad_enterprise_deploy = {
    for variable in data.tfe_variables.nomad_enterprise_deploy.terraform :
    variable.name => variable.value
    if !variable.sensitive
  }

  # Lookup the required variable explicitly, handling the case
  # when the workspace hasn't been created yet.
  nomad_deploy_ec2_key_pair_name = lookup(local.nomad_enterprise_deploy, "ec2_key_pair_name", null)

  # Read non-sensitive workspace variables to avoid hardcoding values
  # that should be set out of band.
  consul_enterprise_deploy = {
    for variable in data.tfe_variables.consul_enterprise_deploy.terraform :
    variable.name => variable.value
    if !variable.sensitive
  }

  # Lookup the required variable explicitly, handling the case
  # when the workspace hasn't been created yet.
  consul_deploy_ec2_key_pair_name = lookup(local.consul_enterprise_deploy, "ec2_key_pair_name", null)

  # Read non-sensitive workspace variables to avoid hardcoding values
  # that should be set out of band.
  pingfederate_deploy = {
    for variable in data.tfe_variables.pingfederate_deploy.terraform :
    variable.name => variable.value
    if !variable.sensitive
  }

  # Lookup the required variable explicitly, handling the case
  # when the workspace hasn't been created yet.
  pingfederate_deploy_ec2_key_pair_name = lookup(local.pingfederate_deploy, "ec2_key_pair_name", null)
}
