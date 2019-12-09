# Service Control Policies

This module uses an [allow list](https://docs.aws.amazon.com/organizations/latest/userguide/SCP_strategies.html#orgs_policies_allowlist)
to control access to services.
It is intended to be applied to an account or org unit. Each account, org unit and the org need to have at least one SCP directly attached to it.
This acts as a replacement for the FullAWSAccess policy which is attached by default.

