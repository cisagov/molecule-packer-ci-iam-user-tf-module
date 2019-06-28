# molecule-packer-travisci-iam-user-tf-module ⚛️📦🏗 #

[![Build Status](https://travis-ci.com/cisagov/molecule-packer-travisci-iam-user-tf-module.svg?branch=develop)](https://travis-ci.com/cisagov/molecule-packer-travisci-iam-user-tf-module)

A Terraform module that creates an AWS IAM user that can build AMIs via
packer and/or access SSM parameters.

See [here](https://www.terraform.io/docs/modules/index.html) for more
details on Terraform modules and the standard module structure.

## Usage ##

```hcl
module "iam_user" {
  source = "github.com/cisagov/molecule-packer-travisci-iam-user-tf-module"

  ssm_parameters = ["/github/oauth_token"]
  user_name      = "test-ansible-role-cyhy-core"
  tags = {
    Team        = "NCATS OIS - Development"
    Application = "ansible-role-cyhy-core testing"
  }
}
```

## Examples ##

* See the [example README](examples/README.md).

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-------:|:--------:|
| ssm_parameters | The AWS SSM parameters that the IAM user needs to be able to read | list(string) | | yes |
| user_name | The name to associate with the AWS IAM user (e.g. test-ansible-role-cyhy-core) | string | | yes |
| add_packer_permissions | Whether or not to give the IAM user the permissions needed by packer to create an AMI | bool | `false` | no |
| tags | Tags to apply to all AWS resources created | map(string) | `{}` | no |

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
