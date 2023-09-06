#!/usr/bin/env bash

set -euxo pipefail

cargo binstall -y rsign2

# TODO: decrypt minisign.key.enc > minisign.key

ts=$(date --utc --iso-8601=seconds)
git=$(git rev-parse HEAD)
comment="gh=$GITHUB_REPOSITORY git=$git ts=$ts run=$GITHUB_RUN_ID"

for file in "$@"; do
    rsign sign -s minisign.key -x "$file.sig" -t "$comment" "$file"
done

rm minisign.key
