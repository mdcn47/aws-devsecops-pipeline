variable "resource_prefix" {
  type        = string
  description = "Prefix for AWS Resources"
  default     = "mdcn"
}

variable "eks_cluster_name" {
  type        = string
  description = "Name of the EKS Cluster"
  default     = "mdcn-devsecops-cluster"
}

variable "region" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
}

variable "SNYK_TOKEN" {}
variable "SNYK_ORG_ID" {}