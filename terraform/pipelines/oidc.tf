# OIDC Provider for Terraform Cloud
resource "aws_iam_openid_connect_provider" "terraform_cloud" {
  url             = "https://app.terraform.io"
  client_id_list  = ["aws.workload.identity"]
  thumbprint_list = ["9e99a48a9960b14926bb7f3b02e22da2b0ab7280"]
}

# IAM Role for Terraform Cloud
resource "aws_iam_role" "terraform_cloud" {
  name = "terraform-cloud-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = aws_iam_openid_connect_provider.terraform_cloud.arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "app.terraform.io:aud" = "aws.workload.identity"
          },
          StringLike = {
            "app.terraform.io:sub" = "organization:DSB:workspace:dsb-aws-devsecops-pipelines:run_phase:*"
          }
        }
      }
    ]
  })
}

# Attach necessary policies to the role
resource "aws_iam_role_policy_attachment" "terraform_cloud_admin" {
  role       = aws_iam_role.terraform_cloud.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
} 