provider "aws" {
  region = var.region
}

terraform {
  cloud {
    organization = "MDCN"

    workspaces {
      name = "aws-devsecops-eks-cluster"
    }
  }
}