.PHONY: init apply plan

init:
	terraform init -backend-config=config.tfvars

plan:
	terraform plan -var-file=config.tfvars

apply:
	terraform apply -var-file=config.tfvars
