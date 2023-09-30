terraform {
  backend "s3" {
    bucket = "twotierarchaws"
    key    = "backend/twoTierArchitecture_AWS.tfstate"
    region = "us-east-1"
    dynamodb_table = "backend_remote"
  }
}
