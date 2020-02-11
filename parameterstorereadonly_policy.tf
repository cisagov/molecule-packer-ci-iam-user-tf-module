# ------------------------------------------------------------------------------
# Create the IAM policy that allows read-only access to the specified
# SSM Parameter Store parameters in the Images account.
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "parameterstorereadonly_doc" {
  statement {
    actions = [
      "ssm:GetParameter",
      "ssm:GetParameters"
    ]
    resources = formatlist("arn:aws:ssm:*:%s:parameter%s", local.images_account_id, var.ssm_parameters)
  }
}

resource "aws_iam_policy" "parameterstorereadonly_policy" {
  description = local.parameterstorereadonly_role_description
  name        = local.parameterstorereadonly_role_name
  policy      = data.aws_iam_policy_document.parameterstorereadonly_doc.json
}
