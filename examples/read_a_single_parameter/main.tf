# Default AWS provider for the Images account
provider "aws" {
  region  = "us-east-1"
  profile = "cool-images-provisionaccount"
}

# AWS provider for the Users account
provider "aws" {
  region  = "us-east-1"
  profile = "cool-users-provisionaccount"
  alias   = "users"
}

module "iam_user" {
  source = "github.com/cisagov/molecule-packer-ci-iam-user-tf-module"

  providers = {
    aws       = aws
    aws.users = aws.users
  }

  images_account_id = "111111111111"
  ssm_parameters    = ["/github/oauth_token"]

  user_name = "test-ansible-role-cyhy-core"
  tags = {
    Team        = "VM Fusion - Development"
    Application = "ansible-role-cyhy-core testing"
  }
}
