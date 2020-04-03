VERSION?=$(shell git describe --tags 2> /dev/null || echo '0.0.0')
DOCKER_IMAGE=minimsecure/ruby-ci-docker-image

# This is the old (bloated) image
.PHONY: image
image:
	docker build \
		-t $(DOCKER_IMAGE):$(VERSION) \
		-t $(DOCKER_IMAGE):latest \
		-f Dockerfile \
		.

.PHONY: images
images: image

.PHONY: docker/push/image
docker/push/image:
	@docker push $(DOCKER_IMAGE):$(VERSION)
	@docker push $(DOCKER_IMAGE):latest

.PHONY: docker/push
docker/push: docker/push/image
