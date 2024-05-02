#!/usr/bin/env bash

rm -rf devnet
mkdir -p devnet/ipc
cp config/* devnet
cp -r credentials devnet
echo '{"Producers": []}' > devnet/topology.json
sed -i.bak "s/\"startTime\": [0-9]*/\"startTime\": $(date +%s)/" "devnet/genesis-byron.json" && \
sed -i.bak "s/\"systemStart\": \".*\"/\"systemStart\": \"$(date -u +%FT%TZ)\"/" "devnet/genesis-shelley.json"
find devnet -type f -exec chmod 0400 {} \;
echo "Prepared devnet, you can start the cluster now"

