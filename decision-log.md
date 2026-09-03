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

# Website hosting

## Drivers

- The personal website is a static Hugo site with low traffic
- S3 plus CloudFront needs a Lambda@Edge function to serve directory index files, and it does not work for all paths
- Route 53 costs money for a zone that holds a handful of records

## Decision

- Host the website on Cloudflare Pages, built from the GitHub repository on push
- Move the zone to Cloudflare DNS, managed in the saschaeglaucom-cloudflare component
- Cut over in two steps: first move DNS while it still points at CloudFront, then switch the records to Pages
- Keep files that are not in git, like the resume, in an R2 bucket served at files.saschaeglau.com. Old /files/ links redirect there
- Delete the saschaeglaucom and mail components once the site runs on Pages

# Terraform State Storage for Cloudflare

## Drivers

- Cloudflare components should not depend on AWS credentials
- The existing S3 backend pattern should carry over

## Decision

- Store the state of Cloudflare components in one R2 bucket per Cloudflare account, through the S3 backend
- Lock with the S3 backend lockfile. R2 supports the conditional write it needs, so no lock table
- Create the bucket once by hand, then import it into the cloudflare-account component
- Accept that R2 has no object versioning, so there is no state history
