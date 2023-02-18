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

# For folders to backup see
# https://github.com/ledgerwatch/erigon/discussions/6891
# For the description of this command see
# https://stackoverflow.com/a/75483439/315168
time (cd $DATA_DIR && tar -cf - chaindata bor nodes parlia snapshot | pv | zstd -f -T0 -8 -o $TARGET)
