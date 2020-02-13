# IAM policy document that allows assumption of the ParameterStoreReadOnly
# role (in the Images account) for this user
data "aws_iam_policy_document" "assume_parameterstorereadonly_role_doc" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    resources = [
      aws_iam_role.parameterstorereadonly_role.arn
    ]
  }
}

# The IAM policy allowing this user to assume their custom
# ParameterStoreReadOnly role in the Images account
resource "aws_iam_user_policy" "assume_parameterstorereadonly" {
  name   = "Images-Assume${local.parameterstorereadonly_role_name}"
  user   = aws_iam_user.user.name
  policy = data.aws_iam_policy_document.assume_parameterstorereadonly_role_doc.json
}
