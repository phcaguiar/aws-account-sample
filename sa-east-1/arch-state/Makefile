FILE = ../project.tfvars
PROJECT-NAME = $(shell grep -w project-name $(FILE) | awk '{print $$3}')
#PROFILE-NAME = $(shell grep -w project-name $(FILE) | awk '{print $$3}')-admin
TF-FILE = $(shell pwd | xargs basename | awk -F- '{print $$1}')
ACCOUNTID = $(shell grep -w account-id $(FILE) | awk '{print $$3}')
REGION = $(shell grep -w region $(FILE) | awk '{print $$3}')
EMPTY =

ifeq ($(REGION),$(EMPTY))
	REGION = $(shell pwd | awk -F/ '{print $$(NF-1)}')
endif

check_vars:
	@echo 'Conta: ' $(ACCOUNTID)
	@echo 'Regiao: ' $(REGION)
	@echo 'Projeto: ' $(PROJECT-NAME)

target:
	@echo $(PROJECT-NAME)

base_dir = ./.terraform

check-python2:
	@python2 --version 2> /dev/null || (echo "Please install Python version 2 interpreter: https://www.python.org/" && exit 1);

check-awscli: check-python2
	@aws --version > /dev/null || (echo "Please install AWS CLI: https://aws.amazon.com/cli/" && exit 1);

check-terraform: check-awscli
	@terraform -v 2> /dev/null || (echo "Please install the latest version of Terraform: https://www.terraform.io/downloads.html" && exit 1);

getawscred:
	@aws configure --profile $(PROJECT-NAME) ; rm -rf .config ; mkdir .config ; cp ~/.aws/credentials .config ; rm -rf ~/.aws/credentials

clean:
	@rm -rf .terraform

config: check-terraform
	@terraform init 

plan: check-terraform
	@terraform plan -var-file=$(FILE)

apply: check-terraform getawscred
	@terraform apply -var-file=$(FILE)

destroy: check-terraform
	@terraform destroy -var-file=$(FILE)
