#!/bin/bash

docker exec \
-it \
-w /mount/data/node1 \
-e CARDANO_NODE_SOCKET_PATH=/mount/data/node1/node.socket \
node1 bash