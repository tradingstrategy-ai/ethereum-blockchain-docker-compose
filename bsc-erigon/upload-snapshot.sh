#!/bin/sh
#
# Upload snapshot to Storj cloud
#
#
# To install Uplink CLI, see https://docs.storj.io/dcs/downloads/download-uplink-cli
#
#   curl -L https://github.com/storj/storj/releases/latest/download/uplink_linux_amd64.zip -o uplink_linux_amd64.zip
#   unzip -o uplink_linux_amd64.zip
#   sudo install uplink /usr/local/bin/uplink
#
# Then you need to get Access grant in Storj web UI, it's 1024 bytes string
#
#   export ACCESS_GRANT=1Hy5s...
#   uplink access import main $ACCESS_GRANT
#
# This is an interactive (y/n) process and will create /root/.config/storj/uplink/access.json
#
#
set -e

# The snapshot archive we are uploading
TARGET=/bsc/snapshot-2023-02.tar.zst

SHARED_FILENAME=bnb-chain-snapshot-2023-23.tar.zst

# Created in the web UI
BUCKET=bnb-chain-snapshot

# Upload rate 20 MBytes/sec
uplink cp $TARGET sj://$BUCKET/$SHARED_FILENAME

# Get a share URL
uplink share --not-after=none --url sj://$BUCKET/SHARED_FILENAME