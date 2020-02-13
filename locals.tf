# The AWS account ID being used
data "aws_caller_identity" "current" {}

locals {
  # If var.images_account_id is not set, default to the calling account
  images_account_id = var.images_account_id != "" ? var.images_account_id : data.aws_caller_identity.current.account_id

  # If var.parameterstorereadonly_role_description contains "%s", use format()
  # to replace the "%s" with var.user_name, otherwise just use
  # var.parameterstorereadonly_role_description as is
  parameterstorereadonly_role_description = length(regexall(".*%s.*", var.parameterstorereadonly_role_description)) > 0 ? format(var.parameterstorereadonly_role_description, var.user_name) : var.parameterstorereadonly_role_description

  # If var.parameterstorereadonly_role_name contains "%s", use format()
  # to replace the "%s" with var.user_name, otherwise just use
  # var.parameterstorereadonly_role_name as is
  parameterstorereadonly_role_name = length(regexall(".*%s.*", var.parameterstorereadonly_role_name)) > 0 ? format(var.parameterstorereadonly_role_name, var.user_name) : var.parameterstorereadonly_role_name
}
