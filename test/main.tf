terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.7.0"
    }
  }

  backend "local" {}
}

provider "aws" {
  region = "us-east-1"
}
