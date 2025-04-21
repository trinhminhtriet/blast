NAME    := blast
PACKAGE := github.com/trinhminhtriet/$(NAME)
DATE    :=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
GIT     := $(shell [ -d .git ] && git rev-parse --short HEAD)
VERSION := $(shell git describe --tags 2>/dev/null || echo "v0.0.0")

default: build

tidy:
	go get -u && go mod tidy

build:
	go build

build-link:
	go build
	mkdir -p ${PWD}/dist
	mv ${NAME} ${PWD}/dist/${NAME}
  rm -rf /usr/local/bin/${NAME}
	ln -s ${PWD}/dist/${NAME} /usr/local/bin/${NAME}

release:
	goreleaser build --clean --snapshot --single-target

release-all:
	goreleaser build --clean --snapshot

clean:
	rm -rf /usr/local/bin/${NAME}
	rm -rf dist

.PHONY: default tidy build build-link release release-all clean
