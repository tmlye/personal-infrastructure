# Personal Infrastructure

This repository contains the code for my personal infrastructure. It is hosted on AWS and provisioned via Terraform.

- [aws-org](aws-org) is used to manage the AWS organization, which includes the various accounts and service control policies
- [danieleglaucom](danieleglaucom) provisions an S3 bucket, cloudfront, acm and route 53 for [my bother's personal website](https://danieleglau.com/)
- [mail](mail) sets up DNS records for using saschaeglau.com with Protonmail. I used to run my own mailserver but no longer do.
- [saschaeglaucom](saschaeglaucom) provisions an S3 bucket, cloudfront, acm and route 53 for my [personal website](https://saschaeglau.com/)
- [terraform-modules](terraform-modules) contains various modules which are reused among the terraform configs
