all: build

build:
	docker run --rm -it \
		-v ${PWD}:/workspace/source \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-v ${HOME}/.docker/config.json:/root/.docker/config.json:ro \
		-v ${HOME}/.skaffold:/root/.skaffold \
		-v ${HOME}/.cache/pip:/root/.cache/pip \
		-e SKAFFOLD_DEFAULT_REPO=$(if $(SKAFFOLD_DEFAULT_REPO),$(SKAFFOLD_DEFAULT_REPO),) \
		-e PIP_DOWNLOAD_CACHE=/root/.cache/pip \
		-w /workspace/source \
		--entrypoint skaffold \
		--network host \
		gcr.io/k8s-skaffold/skaffold:028a21bc1a4edff29e1ddae0015089aa43ac812b build

.PHONY: build all
