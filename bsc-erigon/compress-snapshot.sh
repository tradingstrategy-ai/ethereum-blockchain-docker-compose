#!/bin/sh
#
# Create an Erigon snapshot archive.
# Make sure the Erigon docker is stopped before running this.
#

set -e

# zstd archives have .zst extension
TARGET=/bsc/snapshot-2023-02.tar.zst

time (cd /bsc/data/bsc-erigon/ && tar -cf $TARGET --use-compress-program=zstdmt chaindata bor nodes)

# Viewing archive contents
# tar -tf $TARGET --use-compress-program=zstdmt

# To uncompress
# tar -xf $TARGET --use-compress-program=zstdmt