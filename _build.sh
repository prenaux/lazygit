#!/bin/bash -e
#
# How to build:
#   cd lazygit
#   . hat
#   ./_build.sh
#

if [ -d "./bin" ]; then
  echo "Removing previous bin build dir..."
  (set -x ; rm -Rf ./bin)
fi

build_lazygit() {
    local GOOS=$1
    local GOARCH=$2
    local output=$3

    echo "Building for $GOOS $GOARCH..."
    (set -x ; env GOOS=$GOOS GOARCH=$GOARCH go build -o "$output" -ldflags="-s -w" -tags=osusergo,netgo)
}

# Build for Linux x64
build_lazygit linux amd64 "bin/lin-x64/lazygit"

# Build for macOS x64
build_lazygit darwin amd64 "bin/osx-x64/lazygit"

# Build for macOS arm64
build_lazygit darwin arm64 "bin/osx-arm64/lazygit"

# Build for Windows x64
build_lazygit windows amd64 "bin/nt-x64/lazygit.exe"

