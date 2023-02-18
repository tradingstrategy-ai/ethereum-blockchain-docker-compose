#!/bin/sh
#
# Create an Erigon snapshot archive.
# Make sure the Erigon docker is stopped before running this.
# We compress chaindata, bor and nodes folder of Erigon data.
#

# To begin
# apt install pv zstd

set -e

# zstd archives have .zst extension
DATA_DIR=/bsc/data/bsc-erigon/
TARGET=/bsc/snapshot-2023-02.tar.zst

time (cd $DATA_DIR && tar -cf - chaindata bor nodes parlia | pv | zstd -f -T0 -8 -o $TARGET)

# Viewing archive contents
# tar -tf $TARGET --use-compress-program=zstdmt

# To uncompress
# tar -xf $TARGET --use-compress-program=zstdmt