# IAM policy document that allows assumption of the EC2AMICreate
# role (in the Images account) for this user
data "aws_iam_policy_document" "assume_ec2amicreate_role_doc" {
  count = var.add_packer_permissions ? 1 : 0

  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    resources = [
      "arn:aws:iam::${var.images_account_id}:role/${var.ec2amicreate_role_name}"
    ]
  }
}

# The IAM policy allowing this user to assume their custom
# EC2AMICreate role in the Images account
resource "aws_iam_user_policy" "assume_ec2miwrite" {
  count = var.add_packer_permissions ? 1 : 0

  name   = "Images-Assume${var.ec2amicreate_role_name}"
  user   = aws_iam_user.user.name
  policy = data.aws_iam_policy_document.assume_ec2amicreate_role_doc[count.index].json
}
