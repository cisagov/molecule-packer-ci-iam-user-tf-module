# This is the provider that is used to create the role that can
# create AMIs inside the Images account
provider "aws" {
  alias = "images-ProvisionEC2AMICreateRoles"
}

# This is the provider that is used to create the policy that can
# read Parameter Store parameters inside the Images account
provider "aws" {
  alias = "images-ProvisionParameterStoreReadRoles"
}

# This is the default provider that is used to create resources inside
# the Users account
provider "aws" {
}
