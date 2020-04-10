.PHONY: init apply plan

init:
	terraform init -backend-config=backend_config.tfvars

plan:
	terraform plan -var-file=config.tfvars

apply:
	terraform apply -var-file=config.tfvars
