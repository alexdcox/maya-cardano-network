#!/bin/sh

# export CARDANO_BLOCK_PRODUCER=true

mkdir -p /mount/data/node1
mv /mount/data/genesis/delegate-keys/*.000.* /mount/data/node1/
cd /mount/data/node1

# CARDANO_CONFIG=/mount/data/node1/node-config.json \
# CARDANO_DATABASE_PATH=/mount/data/node1/db \
# CARDANO_PORT=3001 \
# CARDANO_SOCKET_PATH=/mount/data/node1/node.socket \
# CARDANO_SHELLEY_KES_KEY=/mount/data/node1/kes.skey \
# CARDANO_SHELLEY_VRF_KEY=/mount/data/node1/vrf.skey \
# CARDANO_SHELLEY_OPERATIONAL_CERTIFICATE=/mount/data/node1/opcert.cert \
# CARDANO_LOG_DIR=/opt/cardano/logs \
# CARDANO_TOPOLOGY=/mount/template/topology.json \
# CARDANO_BIND_ADDR=0.0.0.0 \

CARDANO_BLOCK_PRODUCER=true \
cardano-node run \
--config /mount/data/genesis/node-config.json \
--topology /mount/template/topology.json \
--database-path db \
--socket-path node.socket \
--host-addr 0.0.0.0 \
--port 3000 \
--byron-delegation-certificate byron.000.cert.json \
--byron-signing-key byron.000.key \
--shelley-kes-key shelley.000.kes.skey \
--shelley-vrf-key shelley.000.vrf.skey \
--shelley-operational-certificate shelley.000.opcert.json
