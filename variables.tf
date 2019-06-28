# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "ssm_parameters" {
  type        = list(string)
  description = "The AWS SSM parameters that the IAM user needs to be able to read"
}

variable "user_name" {
  description = "The name to associate with the AWS IAM user (e.g. test-ansible-role-cyhy-core)"
}

# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------

variable "add_packer_permissions" {
  type        = bool
  description = "Whether or not to give the IAM user the permissions needed by packer to create an AMI"
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all AWS resources created"
  default     = {}
}
