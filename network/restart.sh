#!/bin/bash

commonArgs="
  --rm \
  --name node1 \
  -it \
  --network cardano \
  -v $(pwd)/template:/mount/template:ro \
  -v $(pwd)/data:/mount/data
"

rm -rf ./data/node1/db

sd 'startTime": ?[0-9]+' "startTime\":$(date -u +%s)" ./data/genesis/byron-genesis.json
sd 'systemStart": ?".*"' "systemStart\": \"$(date -u +%FT%TZ)\"" ./data/genesis/shelley-genesis.json
sd '"[A-z]+GenesisHash": ?".*?",' '' ./data/genesis/node-config.json

docker run \
  --entrypoint /mount/template/node1.sh \
  $commonArgs \
  ghcr.io/intersectmbo/cardano-node:8.9.1

