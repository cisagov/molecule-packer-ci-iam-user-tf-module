# IAM policy document that allows assumption of the AMIWrite
# role (in the Images account) for this user
data "aws_iam_policy_document" "assume_amiwrite_role_doc" {
  count = var.add_packer_permissions ? 1 : 0

  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    resources = [
      aws_iam_role.amiwrite_role[count.index].arn
    ]
  }
}

# The IAM policy allowing this user to assume their custom
# AMIWrite role in the Images account
resource "aws_iam_user_policy" "assume_amiwrite" {
  count = var.add_packer_permissions ? 1 : 0

  provider = aws.users

  name   = "Images-Assume${local.amiwrite_role_name}"
  user   = aws_iam_user.user.name
  policy = data.aws_iam_policy_document.assume_amiwrite_role_doc[count.index].json
}
