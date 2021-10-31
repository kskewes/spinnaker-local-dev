# Spinnaker local dev Makefile

# Make defaults
# Use commonly available shell
SHELL := bash
# Fail if piped commands fail - critical for CI/etc
.SHELLFLAGS := -o errexit -o nounset -o pipefail -c
# Use one shell for a target, rather than shell per line
.ONESHELL:

all: help

.PHONY: create
create: ## Create KinD cluster
	kind create cluster --name spinnaker-local-dev --config kind.yml

.PHONY: apply
apply: ## Apply Kubernetes configuration via kustomize
	kubectl apply -k .

.PHONY: delete
delete: ## Delete KinD cluster
	kind delete cluster --name spinnaker-local-dev

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


