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

variable "ec2amiwrite_role_name" {
  description = "The name of the IAM role in the Images account that allows all of the EC2 actions needed to create an AMI."
  default     = "EC2AMIWrite"
}

variable "images_account_id" {
  description = "The AWS account ID containing the SSM parameter store that the IAM user needs to read from and also where the user will be allowed to create images (if add_packer_permissions is true); if not provided, the current calling account ID is used"
  default     = ""
}

variable "parameterstorereadonly_role_description" {
  description = "The description to associate with the IAM role (as well as the corresponding policy) that allows read-only access to the specified SSM ParameterStore parameters.  Note that a \"%s\" in this value will get replaced with the user_name variable."
  default     = "Allows read-only access to SSM ParameterStore required for %s."
}

variable "parameterstorereadonly_role_name" {
  description = "The name to assign the IAM role (as well as the corresponding policy) that allows read-only access to SSM ParameterStore.  Note that a \"%s\" in this value will get replaced with the user_name variable."
  default     = "ParameterStoreReadOnly-%s"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all AWS resources created"
  default     = {}
}
