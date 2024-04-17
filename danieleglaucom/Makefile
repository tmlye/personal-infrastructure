.PHONY: init apply plan destroy

init:
	terraform init -backend-config=backend.tfvars

plan:
	terraform plan -var-file=config.tfvars

apply:
	terraform apply -var-file=config.tfvars

destroy:
	terraform destroy -var-file=config.tfvars
