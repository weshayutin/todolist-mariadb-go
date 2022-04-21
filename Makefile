REGISTRY ?= quay.io/mferrato
REPO ?= todolist-mariadb-go
IMAGE ?= $(REGISTRY)/$(REPO)

DOCKERFILE ?= Dockerfile

VERSION ?= v1

TAG_LATEST ?= false

ifeq ($(TAG_LATEST), true)
	IMAGE_TAGS ?= $(IMAGE):$(VERSION) $(IMAGE):latest
else
	IMAGE_TAGS ?= $(IMAGE):$(VERSION)
endif

ifeq ($(shell docker buildx inspect 2>/dev/null | awk '/Status/ { print $$2 }'), running)
	BUILDX_ENABLED ?= true
else
	BUILDX_ENABLED ?= false
endif

define BUILDX_ERROR
buildx not enabled, refusing to run this recipe
endef

PLATFORMS ?= linux-amd64,linux-arm64,linux-ppc64le,linux-s390x
BUILDX_PLATFORMS := $(shell echo '$(PLATFORMS)' | sed -e "s/-/\//g" )
BUILDX_OUTPUT_TYPE ?= registry

containers:
ifneq ($(BUILDX_ENABLED), true)
	$(error $(BUILDX_ERROR))
endif
	@echo "Buildx plaforms: $(BUILDX_PLATFORMS)" 
	@docker buildx build  \
	--output=type=$(BUILDX_OUTPUT_TYPE) \
	--platform $(BUILDX_PLATFORMS) \
	$(addprefix -t , $(IMAGE_TAGS)) \
	-f $(DOCKERFILE) .
	@echo "manifest: $(IMAGE_TAGS)"
