#!/bin/bash
#
# This file is mounted within the BSC container and used to start geth
#

set -e
set -x

echo "Launching Binance Smart chain node using network $NETWORK"

cd /data;
if [ ! -f '/data/genesis.json' ] ; then
  unzip /$NETWORK'net.zip'
fi

# Initial BSC genesic block from the zip archive
geth \
  --datadir . \
  --verbosity 4 \
  init genesis.json

# ????
sed -i '/^HTTP/d' ./config.toml

# Launch geth daemon
# syncmode=snap is now disabled https://github.com/binance-chain/bsc/issues/288#issuecomment-864419400
geth \
  --config /config.toml \
  --datadir . \
  --http.port 9545 \
  --gcmode archive \
  --verbosity 9 \
  --syncmode=fast
  --

#  --pprof \
#  --metrics \
#  --graphql \
#  --graphql.addr 0.0.0.0 \
#  --graphql.port 8587 \
#  --graphql.corsdomain '*' \
#  --graphql.vhosts '*' \

