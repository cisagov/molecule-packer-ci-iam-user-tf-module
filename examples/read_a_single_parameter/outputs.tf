output "user_name" {
  value       = "${module.iam_user.user_name}"
  description = "The IAM user's name"
}

output "user_arn" {
  value       = "${module.iam_user.user_arn}"
  description = "The IAM user's ARN"
}

output "access_key_id" {
  value       = "${module.iam_user.access_key_id}"
  description = "The IAM access key ID"
}

output "access_key_secret" {
  value       = "${module.iam_user.access_key_secret}"
  description = "The IAM access key secret"
  sensitive   = true
}
