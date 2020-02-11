# ------------------------------------------------------------------------------
# Create the IAM role that allows all of the EC2 actions needed to create
# an AMI in the Images account.
# ------------------------------------------------------------------------------

resource "aws_iam_role" "amiwrite_role" {
  count = var.add_packer_permissions ? 1 : 0

  assume_role_policy = data.aws_iam_policy_document.assume_role_doc.json
  description        = local.amiwrite_role_description
  name               = local.amiwrite_role_name
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "amiwrite_policy_attachment" {
  count = var.add_packer_permissions ? 1 : 0

  policy_arn = aws_iam_policy.amiwrite_policy[count.index].arn
  role       = aws_iam_role.amiwrite_role[count.index].name
}
