#!/bin/bash -e
#
# How to build:
#   cd lazygit
#   . hat
#   ./_build.sh
#

BUILD_COMMIT=$(git rev-parse HEAD)
BUILD_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
BUILD_SOURCE="prenaux/lazygit"

if [ -d "./bin" ]; then
  echo "Removing previous bin build dir..."
  (set -x ; rm -Rf ./bin)
fi

build_lazygit() {
    local GOOS=$1
    local GOARCH=$2
    local output=$3

    local LDFLAGS="-s -w"
    LDFLAGS="${LDFLAGS} -X main.commit=${BUILD_COMMIT}"
    LDFLAGS="${LDFLAGS} -X main.date=${BUILD_DATE}"
    LDFLAGS="${LDFLAGS} -X main.buildSource=${BUILD_SOURCE}"

    echo "Building for $GOOS $GOARCH..."
    (set -x ; env GOOS=$GOOS GOARCH=$GOARCH go build -o "$output" -ldflags="${LDFLAGS}" -tags=osusergo,netgo)
    echo "Done building for $GOOS $GOARCH..."
}

# Build for Windows x64
build_lazygit windows amd64 "bin/nt-x64/lazygit.exe"

# Build for macOS arm64
build_lazygit darwin arm64 "bin/osx-arm64/lazygit"

# Build for Linux x64
build_lazygit linux amd64 "bin/lin-x64/lazygit"

# Build for macOS x64
build_lazygit darwin amd64 "bin/osx-x64/lazygit"

echo "Done building all lazygit."
