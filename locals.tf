locals {
  aws_account_number = var.aws_account_number == "" ? data.aws_caller_identity.current.account_id : var.aws_account_number
  aws_region         = var.aws_region == "" ? data.aws_region.current.name : var.aws_region
}
