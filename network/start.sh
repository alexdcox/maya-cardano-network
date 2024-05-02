#!/bin/bash

# run node

docker run \
  --entrypoint /mount/template/node1.sh \
  --rm \
  --name node1 \
  -it \
  --network cardano \
  -v $(pwd)/template:/mount/template:ro \
  -v $(pwd)/data:/mount/data \
  ghcr.io/intersectmbo/cardano-node:8.9.1
