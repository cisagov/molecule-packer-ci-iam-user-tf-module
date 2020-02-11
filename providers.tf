# This is the "default" provider that is used to create resources
# inside the Images account
provider "aws" {
}

# This is the "users" provider that is used to create resources inside
# the Users account
provider "aws" {
  alias = "users"
}
