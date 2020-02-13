# ------------------------------------------------------------------------------
# Create the IAM role that allows read-only access to the specified
# SSM Parameter Store parameters in the Images account.
# ------------------------------------------------------------------------------

resource "aws_iam_role" "parameterstorereadonly_role" {
  provider = aws.images-ProvisionParameterStoreReadRoles

  assume_role_policy = data.aws_iam_policy_document.assume_role_doc.json
  description        = local.parameterstorereadonly_role_description
  name               = local.parameterstorereadonly_role_name
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "parameterstorereadonly_policy_attachment" {
  provider = aws.images-ProvisionParameterStoreReadRoles

  policy_arn = aws_iam_policy.parameterstorereadonly_policy.arn
  role       = aws_iam_role.parameterstorereadonly_role.name
}
