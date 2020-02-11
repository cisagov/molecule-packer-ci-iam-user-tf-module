# ------------------------------------------------------------------------------
# Create an IAM user and an associated access key
# ------------------------------------------------------------------------------

# The user being created
resource "aws_iam_user" "user" {
  provider = aws.users

  name = var.user_name
  tags = var.tags
}

# The IAM access key for the user
resource "aws_iam_access_key" "key" {
  provider = aws.users

  user = aws_iam_user.user.name
}
