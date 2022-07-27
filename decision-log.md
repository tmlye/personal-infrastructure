# Repository Structure

## Drivers

- The individual components must be deployable independently
- It must be possible to share terraform modules between components

## Decision

- Keep terraform modules in a separate folder on top level
- Create folders for each component with their own terraform state
- Include the modules from the components
- Component folders can include other code like Ansible, microservice etc

# AWS account structure

## Drivers

- Personal infrastructure should be separate from side projects
- Common rules (AWS config, SCPs) should apply everywhere

## Decision

- Use AWS organizations to create a separate account for personal infrastructure
- Apply SCPs and AWS config to the entire organization
- Do create resources in the root/master account

# AWS Credentials

## Drivers

- Follow [best practices](https://docs.aws.amazon.com/general/latest/gr/aws-access-keys-best-practices.html)

## Decision

- Use one access key pair for terraform in the master account with MFA enabled
  and assume roles in the child accounts instead of having a keypair per account

# Terraform State Storage

## Drivers

- State should be stored remotely
- The infrastructure for storing state should be managed by terraform
  but without having to manually create it for every component
- State should be "local" to the components, i.e. they should not require access to other accounts

## Decision

- Store the terraform state on S3
- Use one bucket/table per account, sharing it with all components in that account
- Create one bucket and dynamodb table when creating the account
