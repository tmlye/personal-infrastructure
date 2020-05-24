# Personal Infrastructure (work in progress)

This repository contains the code for my personal infrastructure. It is hosted on AWS and provisioned via Terraform.

- [aws-org](aws-org) is used to manage the AWS organization, which includes the various accounts and service control policies
- [backup](backup) creates an S3 bucket and IAM user for backing up my external drive via duplicity
- [saschaeglaucom](saschaeglaucom) provisions an S3 bucket, cloudfront, acm and route 53 for my [personal website](https://saschaeglau.com/)
- [terraform-modules](terraform-modules) contains various modules which are reused among the terraform configs

In the future, I will add:
- A mailserver using postfix and dovecot, including backups
