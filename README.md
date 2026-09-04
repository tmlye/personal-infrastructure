# Personal Infrastructure

This repository contains the code for my personal infrastructure. It is provisioned via Terraform. The website is on Cloudflare, the rest on AWS.

- [aws-org](aws-org) is used to manage the AWS organization, which includes the various accounts and service control policies
- [cloudflare-account](cloudflare-account) manages account level Cloudflare resources, currently the R2 bucket that stores the state of the Cloudflare components
- [saschaeglaucom-cloudflare](saschaeglaucom-cloudflare) manages the Cloudflare zone, DNS records and the Pages project for my [personal website](https://saschaeglau.com/)
- [terraform-modules](terraform-modules) contains various modules which are reused among the terraform configs
