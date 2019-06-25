# Create an IAM User with Permission to Read a Single SSM Parameter #

## Usage ##

To run this example you need to execute the `terraform init` command
followed by the `terraform apply` command.

Note that this example may create resources which cost money. Run
`terraform destroy` when you no longer need these resources.

## Outputs ##

| Name | Description |
|------|-------------|
| user_name | The IAM user's name |
| user_arn | The IAM user's ARN |
| access_key_id | The IAM access key ID |
| access_key_secret | The IAM access key secret |
