#!/bin/bash

set -eu -o pipefail

create_image() {
    local name="$1"
    local ver="$2"
    pushd "${name}"
    docker build -t ghcr.io/bryteise/"${name}":"${ver}" . --build-arg="clear_ver=${ver}"
    popd
}

push_image() {
    local name="$1"
    local ver="$2"
    docker push ghcr.io/bryteise/"${name}":"${ver}"
}

build_and_push_image() {
    local name="$1"
    local ver="$2"
    create_image "${name}" "${ver}"
    push_image "${name}" "${ver}"
}

main() {
    local ver="$1"
    build_and_push_image os-core "${ver}"
}

main $1
