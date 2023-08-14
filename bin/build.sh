#!/bin/bash

set -eo pipefail

package() {
  mvn package
}

copy() {
  ls ./target
  mkdir -p ./docker/assets
  cp ./target/keycloak-rest-provider-1.0.1-SNAPSHOT.jar ./docker/assets/keycloak-rest-provider.jar
}

buildx() {
    echo -e "\033[1mBuilding image: \033[32m${2}\033[1m\033[0m"
    docker buildx create --use >/dev/null

    echo docker buildx build --no-cache --force-rm --compress --load  -t "${1}" -t "${2}" -f "${3}" "${4}"
    docker buildx build --no-cache --force-rm --compress --load -t "${1}" -t "${2}" -f "${3}" "${4}"

    docker buildx stop
    docker buildx rm
}

build() {
    echo docker build --no-cache --force-rm --build-arg KEYCLOAK_IMAGE="${5}" --compress -t "${1}" -t "${2}" -f "${3}" "${4} "
    docker build --no-cache --force-rm --build-arg KEYCLOAK_IMAGE="${5}" --compress -t "${1}" -t "${2}" -f "${3}" "${4}"
}

echo Tag         : "${IMAGE}:latest"
echo Tag         : "${IMAGE}:${CE_TAG}"
echo Docker file : "${DOCKERFILE}"

echo "Packaging"
package

echo "Copying target file "
copy

echo "Build the actual image"
build "${IMAGE}:latest" "${IMAGE}:${CE_TAG}" "${DOCKERFILE}" "docker" "${KEYCLOAK_IMAGE}"
