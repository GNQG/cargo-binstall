#!/usr/bin/env bash

set -euxo pipefail

cargo binstall -y rsign2

rm -f minisign.pub minisign.key
rsign generate -p minisign.pub -s minisign.key -W

cat >> crates/bin/Cargo.toml <<EOF
[package.metadata.binstall.signing]
algorithm = "minisign"
pubkey = "$(tail -n1 minisign.pub)"
EOF
