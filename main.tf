# ------------------------------------------------------------------------------
# CREATE AN IAM USER WITH PERMISSION TO READ THE SPECIFIED SSM
# PARAMETER STORE PARAMETERS.
# ------------------------------------------------------------------------------

# The AWS account ID being used
data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

# The user being created
resource "aws_iam_user" "user" {
  name = var.user_name
  tags = var.tags
}

# The IAM access key for the user
resource "aws_iam_access_key" "key" {
  user = aws_iam_user.user.name
}

# IAM policy documents that allow reading the SSM Parameter Store
# parameters.  This will be applied to the IAM user we are creating.
data "aws_iam_policy_document" "ssm_parameter_doc" {
  count = length(var.ssm_parameters)

  statement {
    effect = "Allow"

    actions = [
      "ssm:GetParameters",
    ]

    resources = formatlist("arn:aws:ssm:%s:%s:parameter/%s", data.aws_region.current.name, data.aws_caller_identity.current.account_id, var.ssm_parameters[count.index])
  }
}

# The SSM policies for our IAM user that lets the user read the SSM
# Parameter Store parameters.
resource "aws_iam_user_policy" "ssm_policy" {
  count = length(var.ssm_parameters)

  user   = aws_iam_user.user.id
  policy = data.aws_iam_policy_document.ssm_parameter_doc[count.index].json
}
