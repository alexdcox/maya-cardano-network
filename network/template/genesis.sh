#!/bin/sh

cardano-cli genesis create-cardano \
--genesis-dir /mount/data/genesis \
--gen-genesis-keys 1 \
--gen-utxo-keys 1 \
--start-time $(date -u -d "now + 2 seconds" +%FT%Tz) \
--supply 30000000000000000 \
--security-param 2160 \
--slot-length 100 \
--slot-coefficient 5/100 \
--testnet-magic 42 \
--byron-template /mount/template/byron.json \
--shelley-template /mount/template/shelley.json \
--alonzo-template /mount/template/alonzo.json \
--conway-template /mount/template/conway.json \
--node-config-template /mount/template/config.json