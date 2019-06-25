output "user_name" {
  value       = "${aws_iam_user.user.name}"
  description = "The IAM user's name"
}

output "user_arn" {
  value       = "${aws_iam_user.user.arn}"
  description = "The IAM user's ARN"
}

output "access_key_id" {
  value       = "${aws_iam_access_key.key.id}"
  description = "The IAM access key ID"
}

output "access_key_secret" {
  value       = "${aws_iam_access_key.key.secret}"
  description = "The IAM access key secret"
  sensitive   = true
}
