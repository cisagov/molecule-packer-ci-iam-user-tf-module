# This is the provider that is used to create the role and policy that can
# read Parameter Store parameters inside the Images account
provider "aws" {
  alias = "images-ProvisionParameterStoreReadRoles"
}

# This is the provider that is used to create resources inside
# the Users account
provider "aws" {
  alias = "users"
}
