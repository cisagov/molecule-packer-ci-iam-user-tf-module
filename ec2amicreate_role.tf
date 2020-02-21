# ------------------------------------------------------------------------------
# Create the IAM role that allows creation of AMIs and read-only access
# to any specified SSM Parameter Store parameters in the Images account.
# ------------------------------------------------------------------------------

resource "aws_iam_role" "ec2amicreate_role" {
  count = var.add_packer_permissions ? 1 : 0

  provider = aws.images-ProvisionEC2AMICreateRoles

  assume_role_policy = data.aws_iam_policy_document.assume_role_doc.json
  description        = local.ec2amicreate_role_description
  name               = local.ec2amicreate_role_name
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "ec2amicreate_policy_attachment" {
  count = var.add_packer_permissions ? 1 : 0

  provider = aws.images-ProvisionEC2AMICreateRoles

  policy_arn = "arn:aws:iam::${local.images_account_id}:policy/${var.ec2amicreate_policy_name}"
  role       = aws_iam_role.ec2amicreate_role[count.index].name
}

resource "aws_iam_role_policy_attachment" "ec2amicreate_parameterstorereadonly_policy_attachment" {
  count = var.add_packer_permissions ? 1 : 0

  provider = aws.images-ProvisionEC2AMICreateRoles

  policy_arn = aws_iam_policy.parameterstorereadonly_policy.arn
  role       = aws_iam_role.ec2amicreate_role[count.index].name
}
