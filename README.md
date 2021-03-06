# molecule-packer-ci-iam-user-tf-module ⚛️📦🏗 #

[![GitHub Build Status](https://github.com/cisagov/molecule-packer-ci-iam-user-tf-module/workflows/build/badge.svg)](https://github.com/cisagov/molecule-packer-ci-iam-user-tf-module/actions)

A Terraform module that creates an AWS IAM user that can build AMIs via
packer and/or access SSM parameters.

Note that two AWS providers are required by this module:

* "aws" - This default provider must allow access to create all necessary IAM
resources in the account where the new user will be created.
* "aws.images-ProvisionParameterStoreReadRoles" - This provider must allow
  creation of a role in the target (Images) account that can read SSM
  Parameter Store parameters.  Note that this must be the same account where
  the AMIs will be created.

See [here](https://www.terraform.io/docs/modules/index.html) for more
details on Terraform modules and the standard module structure.

## Usage ##

```hcl
module "iam_user" {
  source = "github.com/cisagov/molecule-packer-ci-iam-user-tf-module"

  providers = {
    aws                                         = aws
    aws.images-ProvisionParameterStoreReadRoles = aws.images-ProvisionParameterStoreReadRoles
  }

  images_account_id = "111111111111"
  ssm_parameters    = ["/github/oauth_token"]
  user_name         = "test-ansible-role-cyhy-core"
  tags = {
    Team        = "VM Fusion - Development"
    Application = "ansible-role-cyhy-core testing"
  }
}
```

## Examples ##

* See the [example README](examples/README.md).

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-------:|:--------:|
| add_packer_permissions | Whether or not to give the IAM user the permissions needed by packer to create an AMI | bool | `false` | no |
| ec2amicreate_policy_name | The name of the IAM policy in the Images account that allows all of the actions needed to create an AMI. | string | `EC2AMICreate` | no |
| ec2amicreate_role_description | The description to associate with the IAM role that allows this IAM user to create AMIs.  Note that a "%s" in this value will get replaced with the user_name variable. | string | `Allows the %s IAM user to create AMIs` | no |
| ec2amicreate_role_name | The name to assign the IAM role that allows allows this IAM user to create AMIs.  Note that a "%s" in this value will get replaced with the user_name variable. | string | `EC2AMICreate-%s` | no |
| images_account_id | The AWS account ID containing the SSM parameter store that the IAM user needs to read from and also where the user will be allowed to create images (if add_packer_permissions is true); if not provided, the current calling account ID is used | string | ID of calling account | no |
| parameterstorereadonly_role_description | The description to associate with the IAM role (as well as the corresponding policy) that allows read-only access to the specified SSM Parameter Store parameters.  Note that a "%s" in this value will get replaced with the user_name variable. | string | `Allows read-only access to SSM Parameter Store parameters required for %s.` | no |
| parameterstorereadonly_role_name | The name to assign the IAM role (as well as the corresponding policy) that allows read-only access to the specified SSM Parameter Store parameters.  Note that a "%s" in this value will get replaced with the user_name variable. | string | `ParameterStoreReadOnly-%s` | no |
| ssm_parameters | The AWS SSM parameters that the IAM user needs to be able to read | list(string) | | yes |
| tags | Tags to apply to all AWS resources created | map(string) | `{}` | no |
| user_name | The name to associate with the AWS IAM user (e.g. test-ansible-role-cyhy-core) | string | | yes |

## Outputs ##

| Name | Description |
|------|-------------|
| user_name | The IAM user's name |
| user_arn | The IAM user's ARN |
| access_key_id | The IAM access key ID |
| access_key_secret | The IAM access key secret |

## Contributing ##

We welcome contributions!  Please see [here](CONTRIBUTING.md) for
details.

## License ##

This project is in the worldwide [public domain](LICENSE).

This project is in the public domain within the United States, and
copyright and related rights in the work worldwide are waived through
the [CC0 1.0 Universal public domain
dedication](https://creativecommons.org/publicdomain/zero/1.0/).

All contributions to this project will be released under the CC0
dedication. By submitting a pull request, you are agreeing to comply
with this waiver of copyright interest.
