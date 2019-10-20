#!/bin/sh
set -euo pipefail

if ! [ -x "$(command -v aws)" ]; then
  echo 'Error: aws cli is not installed.' >&2
  exit 1
fi

aws --profile ${profile} organizations detach-policy --target-id ${target_id} --policy-id p-FullAWSAccess
