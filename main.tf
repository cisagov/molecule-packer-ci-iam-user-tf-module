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

    resources = formatlist("arn:aws:ssm:%s:%s:parameter%s", data.aws_region.current.name, data.aws_caller_identity.current.account_id, var.ssm_parameters[count.index])
  }
}

# The SSM policies for our IAM user that lets the user read the SSM
# Parameter Store parameters.
resource "aws_iam_user_policy" "ssm_policy" {
  count = length(var.ssm_parameters)

  user   = aws_iam_user.user.id
  policy = data.aws_iam_policy_document.ssm_parameter_doc[count.index].json
  name   = format("terraform_read_ssm_parameters_%d", count.index + 1)
}

# IAM policy documents that allow the EC2 actions needed for packer to create
# AMIs.  This will be applied to the IAM user we are creating.
data "aws_iam_policy_document" "ec2_packer_doc" {
  count = var.add_packer_permissions ? 1 : 0

  statement {
    effect = "Allow"

    actions = [
      "ec2:AttachVolume",
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:CopyImage",
      "ec2:CreateImage",
      "ec2:CreateKeyPair",
      "ec2:CreateSecurityGroup",
      "ec2:CreateSnapshot",
      "ec2:CreateTags",
      "ec2:CreateVolume",
      "ec2:DeleteKeyPair",
      "ec2:DeleteSecurityGroup",
      "ec2:DeleteSnapshot",
      "ec2:DeleteVolume",
      "ec2:DeregisterImage",
      "ec2:DescribeImageAttribute",
      "ec2:DescribeImages",
      "ec2:DescribeInstances",
      "ec2:DescribeInstanceStatus",
      "ec2:DescribeRegions",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSnapshots",
      "ec2:DescribeSubnets",
      "ec2:DescribeTags",
      "ec2:DescribeVolumes",
      "ec2:DetachVolume",
      "ec2:GetPasswordData",
      "ec2:ModifyImageAttribute",
      "ec2:ModifyInstanceAttribute",
      "ec2:ModifySnapshotAttribute",
      "ec2:RegisterImage",
      "ec2:RunInstances",
      "ec2:StopInstances",
      "ec2:TerminateInstances",
    ]

    resources = ["*"]
  }
}

# The EC2 policies for our IAM user that let the user do the actions needed
# by packer to build AMIs.
resource "aws_iam_user_policy" "ec2_packer_policy" {
  count = var.add_packer_permissions ? 1 : 0

  user   = aws_iam_user.user.id
  policy = data.aws_iam_policy_document.ec2_packer_doc[count.index].json
  name   = "terraform_ec2_access_for_packer_ami"
}
