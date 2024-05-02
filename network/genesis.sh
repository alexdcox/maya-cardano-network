#!/bin/bash

# clean / genesis

echo 'Destroying everything except the template files...'
rm -rf ./data && mkdir ./data

docker run \
  --entrypoint /mount/template/genesis.sh \
  --rm \
  --name node1 \
  -it \
  --network cardano \
  -v $(pwd)/template:/mount/template:ro \
  -v $(pwd)/data:/mount/data \
  ghcr.io/intersectmbo/cardano-node:8.9.1

cp ../network-hydra/config/byron-delegate.key ./data/genesis/delegate-keys/byron.000.key
cp ../network-hydra/config/byron-delegation.cert ./data/genesis/delegate-keys/byron.000.cert.json
cp ../network-hydra/config/kes.skey ./data/genesis/delegate-keys/shelley.000.kes.skey
cp ../network-hydra/config/opcert.cert ./data/genesis/delegate-keys/shelley.000.opcert.json
cp ../network-hydra/config/vrf.skey ./data/genesis/delegate-keys/shelley.000.vrf.skey
rm ./data/genesis/delegate-keys/shelley.000.counter.json
rm ./data/genesis/delegate-keys/*.vkey

jq -n 'input | . + (input | pick(.activeSlotsCoeff, .genDelegs, .initialFunds, .maxLovelaceSupply, .updateQuorum, .epochLength, .protocolParams, .staking))' \
  ./data/genesis/shelley-genesis.json \
  ../network-hydra/config/genesis-shelley.json > \
  ./data/genesis/shelley-genesis.json.bak

mv ./data/genesis/shelley-genesis.json.bak ./data/genesis/shelley-genesis.json

jq -n 'input | . + (input | pick(.bootStakeholders, .heavyDelegation, .nonAvvmBalances, .blockVersionData))' \
  ./data/genesis/byron-genesis.json \
  ../network-hydra/config/genesis-byron.json > \
  ./data/genesis/byron-genesis.json.bak

mv ./data/genesis/byron-genesis.json.bak ./data/genesis/byron-genesis.json

jq '. |= with_entries(select(.key|test("Hash")|not)) | .Protocol="Cardano"' \
  ./data/genesis/node-config.json > \
  ./data/genesis/node-config.json.bak

mv ./data/genesis/node-config.json.bak ./data/genesis/node-config.json

