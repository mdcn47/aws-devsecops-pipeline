# Setting up OIDC Authentication for Terraform Cloud

This guide explains how to set up OpenID Connect (OIDC) authentication between Terraform Cloud and AWS for the DevSecOps Pipeline project.

## Prerequisites

1. AWS Account with administrative access
2. Terraform Cloud account
3. Organization and workspace already created in Terraform Cloud

## Setup Steps

### 1. Apply the OIDC Configuration

First, apply the OIDC configuration to create the necessary AWS resources:

```bash
cd terraform/pipelines
terraform init
terraform apply
```

This will create:
- An OIDC provider for Terraform Cloud
- An IAM role that can be assumed by Terraform Cloud
- Required policy attachments

### 2. Configure Terraform Cloud

1. Log in to your Terraform Cloud account
2. Navigate to your organization settings
3. Go to "Provider Configuration"
4. Click "Add Provider Configuration"
5. Select "AWS"
6. Choose "OIDC" as the authentication method
7. Enter the following details:
   - Role ARN: The ARN of the role created in step 1 (output will be shown after terraform apply)
   - Session Duration: 3600 (or your preferred duration)
   - Workspace: dsb-aws-devsecops-pipelines

### 3. Update Workspace Variables

In your Terraform Cloud workspace:

1. Go to "Variables"
2. Add the following environment variables:
   - `TFC_AWS_PROVIDER_AUTH`: true
   - `TFC_AWS_RUN_ROLE_ARN`: The ARN of the role created in step 1

### 4. Verify Configuration

1. Run a plan in Terraform Cloud
2. Check the logs to ensure the OIDC authentication is working
3. Verify that the AWS resources are being created with the correct permissions

## Security Considerations

- The OIDC configuration is scoped to your specific organization and workspace
- The role has administrative access - consider restricting permissions based on your needs
- Regularly rotate the OIDC provider's thumbprint if Terraform Cloud updates their certificates

## Troubleshooting

If you encounter issues:

1. Verify the OIDC provider's thumbprint is correct
2. Check that the role ARN is correctly configured in Terraform Cloud
3. Ensure the workspace name matches exactly in both the IAM role policy and Terraform Cloud
4. Check AWS CloudTrail logs for any authentication failures 