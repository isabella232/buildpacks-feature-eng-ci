#!/bin/bash

set -eu
set -o pipefail

readonly OCCAM_DIR="${PWD}/occam"
readonly VERSION_DIR="${PWD}/version"
readonly ARTIFACTS_DIR="${PWD}/artifacts"

#shellcheck source=../../../util/print.sh
source "${PWD}/ci/util/print.sh"

function main() {
  util::print::title "[task] executing"

  release::prepare
}

function release::prepare() {
  util::print::info "[task] * preparing release"

  local version
  version="$(cat "${VERSION_DIR}/version")"

  printf "v%s" "${version}" > "${ARTIFACTS_DIR}/name"
  printf "v%s" "${version}" > "${ARTIFACTS_DIR}/tag"

  pushd "${OCCAM_DIR}" > /dev/null || return
    git rev-parse HEAD > "${ARTIFACTS_DIR}/commitish"
  popd > /dev/null || return
}

main "${@}"