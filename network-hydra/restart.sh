#!/bin/bash

rm -rf ./db

sd 'startTime": [0-9]+' "startTime\": $(date -u +%s)" ./devnet/genesis-byron.json
sd 'systemStart": ?".*"' "systemStart\": \"$(date -u +%FT%TZ)\"" ./devnet/genesis-shelley.json
# sd '"[A-z]+GenesisHash":".*?",' '' ./data/genesis/node-config.json


docker compose up