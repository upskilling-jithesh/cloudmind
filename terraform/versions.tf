terraform {
  required_version = ">=1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # connect to terraform cloud
  # Workspace auto-creates when terraform init runs
  cloud {
    organization = "jithesh-upskilling"

    workspaces {
      name = "cloudmind-dev"
    }
  }
}
