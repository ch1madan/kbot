APP=$(shell basename $(shell git remote get-url origin))

#SHELL := /bin/bash
#APP := kbot
#VERSION := $(shell git describe --tags --abbrev=0)

linux:
	${MAKE} build TARGETOS=linux TARGETARCH=${TARGETARCH}

macOS:
	${MAKE} build TARGETOS=darwin TARGETARCH=${TARGETARCH}

windows:
	${MAKE} build TARGETOS=windows TARGETARCH=${TARGETARCH} CGO_ENABLED=1

build:
	CGO_ENABLED=${CGO_ENABLED} GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o ch1_bot -ldflags "-X="github.com/ch1madan/kbot/cmd.appVersion=${VERSION}

image:
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH} --build-arg CGO_ENABLED=${CGO_ENABLED} --build-arg TARGETARCH=${TARGETARCH} --build-arg TARGETOS=${TARGETOS}

push:
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

clean:
	docker rmi ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}
	@echo=off rm -f $(APP)
