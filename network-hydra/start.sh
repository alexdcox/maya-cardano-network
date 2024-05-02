#!/bin/bash

docker compose -v down
./prepare-devnet.sh
docker compose up