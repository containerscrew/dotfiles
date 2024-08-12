SHELL:=/bin/sh
.PHONY: all

help: ## this help
	@awk 'BEGIN {FS = ":.*?## ";  printf "Usage:\n  make \033[36m<target> \033[0m\n\nTargets:\n"} /^[a-zA-Z0-9_-]+:.*?## / {gsub("\\\\n",sprintf("\n%22c",""), $$2);printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

doctoc: ## Create table of contents with doctoc
	doctoc .

gitleaks: ## Run gitleaks
	gitleaks detect -v .

sync-config: ## Copy this ./config folder to your ~/.config folder
	rsync -avzu config/* ~/.config/ 

ansible-ping: ## Check connectivity
	ansible all -i inventory.ini -m ping

ansible-playbook-dry-run: ## Run ansible playbook in dry-run mode
	ansible-playbook -i inventory.ini playbook.yml --check --diff --ask-become-pass

ansible-playbook: ## Run ansible playbook
	ansible-playbook -i inventory.ini playbook.yml --ask-become-pass --ask-vault-pass -D

ansible-playbook-tag: ## Run specific tag
	ansible-playbook -i inventory.ini playbook.yml --tags ${TAGS} --ask-become-pass  --ask-vault-pass -D

ansible-encrypt: ## Encrypt vars.yml
	ansible-vault encrypt vars.yml

ansible-decrypt: ## Decrypt vars.yml
	ansible-vault decrypt vars.yml

vscode-extension-list: ## Generate vscode extension list
	code --list-extensions > misc/vscode-extensions.txt