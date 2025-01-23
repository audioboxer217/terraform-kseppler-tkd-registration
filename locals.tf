locals {
  aws_account_number = coalesce(var.aws_account_number, data.aws_caller_identity.current.account_id)
  aws_region         = coalesce(var.aws_region, data.aws_region.current.name)
  cognito_domain     = coalesce(var.admin_user_pool_domain_name, aws_cognito_user_pool.admin_users.id)
  common_tags = {
    "TF_Workspace" = var.TFC_WORKSPACE_NAME
    "Terraform"    = "true"
  }
}
