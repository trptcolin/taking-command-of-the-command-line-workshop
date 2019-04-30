#!/usr/bin/env bash

set -e
set -o pipefail

mkdir -p doc/generated/exercises

# NOTE: uses https://github.com/joeyespo/grip

find doc -name "*.md" -depth 1 -exec bash -c 'grip "$0" --export doc/generated/$(basename $0 .md).html --title="$(basename $0)"' {} \;
find doc/exercises -name "*.md" -depth 1 -exec bash -c 'grip "$0" --export doc/generated/exercises/$(basename $0 .md).html --title="$(basename $0)"' {} \;
