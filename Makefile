SHELL:=/bin/sh
.PHONY: all

help: ## this help
	@awk 'BEGIN {FS = ":.*?## ";  printf "Usage:\n  make \033[36m<target> \033[0m\n\nTargets:\n"} /^[a-zA-Z0-9_-]+:.*?## / {gsub("\\\\n",sprintf("\n%22c",""), $$2);printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

mtoc: ## Create table of contents with mtoc
	mtoc

gitleaks: ## Run gitleaks
	gitleaks detect -v .

sync-local-config: ## Copy this ./config folder to your ~/.config folder
	rsync -avzu config/* ~/.config/

vscode-extension-list: ## Generate vscode extension list
	code --list-extensions > misc/vscode-extensions.txt

remote-sync: ## Sync this repository to remote machine using rsync.
	rsync -avzh --exclude='.git/' $(shell pwd)/ $(USER)@$(IP):/tmp/dotfiles
