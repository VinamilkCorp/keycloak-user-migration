

all: build

help:
	# General commands:
	# make all => build push
	# make prepare - prepare environment variables for given TARGET (arm32/arm64)
	# make info - show information about the current version
	# make version - return the platform and version machine friendly
	#
	# Commands
	# make build - build the vnmidpService image
	# make push - push the image to Docker Hub
	# make push-manifest - push manifest files to Docker hub using TAGLIST variable for choosing the docker images by tag
	# make taglist - returns the taglist
	#

prepare: FORCE

ifeq ($(REPO), dockerhub)
    export MAINTAINER:=vinamilkcorp
else ifeq ($(REPO), acr)
    export MAINTAINER:=vnmcontainerregistry.azurecr.io
else
	$(error unknown Repo >$(REPO)<)
endif

export CE_VERSION:=$(shell ./bin/version.sh)
export CE_TAG:=$(CE_VERSION)
export IMAGE_NAME:=vnmidp
export IMAGE:=$(MAINTAINER)/$(IMAGE_NAME)
export KEYCLOAK_IMAGE:=

info: prepare
	@echo "---"
	@echo Version: $(CE_VERSION)
	@echo Image: $(IMAGE):$(TARGET)
	@echo ""
	@echo Brought to you by lttrung1
	@echo "---"

build: info
	# Build the vnmidp-Service image
	@./bin/build.sh

push: build
	# Push the vnmidp-Service image
	@./bin/push.sh

version:
	@echo $(CE_VERSION)

FORCE:
