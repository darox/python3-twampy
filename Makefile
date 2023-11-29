SHELL := /bin/bash

ROOT := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

K8S_NAMESPACE = twampy
HELM_RELEASE = twampy-dev

.PHONY: release local-up local-down

all: help

## Build and push docker image
release:
	docker buildx build --platform=linux/amd64 --platform=linux/arm64 -t dariomader/twampy:latest --push $(ROOT)

## Start Docker compose stack
local-up:
	docker-compose up --build

## Stop Docker compose stack
local-down:
	docker-compose down

## Deploy twampy k8s setup
k8s-up:
	helm upgrade --install $(HELM_RELEASE) ./install/kubernetes/twampy --namespace $(K8S_NAMESPACE) --create-namespace

## Destroy twampy k8s setup
k8s-down:
	helm uninstall $(HELM_RELEASE) --namespace $(K8S_NAMESPACE)

## Redeploy twampy k8s setup
k8s-redeploy: k8s-down k8s-up

# COLORS
GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
WHITE  := $(shell tput -Txterm setaf 7)
RESET  := $(shell tput -Txterm sgr0)

TARGET_MAX_CHAR_NUM=20
## Show this help
help:
	@echo ''
	@echo 'Usage:'
	@echo '  ${YELLOW}make${RESET} ${GREEN}<target>${RESET}'
	@echo ''
	@echo 'Targets:'
	@awk '/^[a-zA-Z\-\_0-9]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "  ${YELLOW}%-$(TARGET_MAX_CHAR_NUM)s${RESET} ${GREEN}%s${RESET}\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)