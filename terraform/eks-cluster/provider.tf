provider "aws" {
  region = var.region
}

terraform {
  cloud {
    organization = "DSB"

    workspaces {
      name = "aws-devsecops-eks-cluster"
    }
  }
}