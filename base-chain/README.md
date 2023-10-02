
# Installation Notes
CHAINID: 8453

## Step 1: Base snapshot
If you're a prospective or current Base Node operator and would like to restore from a snapshot to save time on the initial sync, it's possible to always get the latest available snapshot of the Base chain on mainnet and/or testnet by using the following CLI commands. The snapshots are updated every hour.

This command will download latest [Mainnet snapshot data](https://github.com/base-org/node#snapshots):

``` 
wget -o - https://base-mainnet-archive-snapshots.s3.us-east-1.amazonaws.com/$(curl https://base-mainnet-archive-snapshots.s3.us-east-1.amazonaws.com/latest) 
```

We will get snapshot file: `base-mainnet-archive-1694415970.tar.gz`

## Step 2: Extract the snapshot data

In this guide we create folder `/base` to store base data:
```
mkdir -p /base
```
Move snapshot file `base-mainnet-archive-1694415970.tar.gz` to `/base`
```
mv base-mainnet-archive-1694415970.tar.gz /base
```

Extract the snapshot, you will get folder `/data`
```
tar -zxvf base-mainnet-archive-1694415970.tar.gz 
```
```
ubuntu@server:/base$ ls -lah
drwxr-xr-x  1 ubuntu ubuntu  116 Sep 22 08:02 ./
drwxr-xr-x 20 root   root   4096 Sep 13 10:06 ../
drwxr-xr-x  1 ubuntu ubuntu   40 Sep 22 08:08 data/
```

## Step3: Download our docker compose for base node
We created `docker-compose` to base node. You can download it at our [github](https://github.com/tradingstrategy-ai/ethereum-blockchain-docker-compose)

```
git clone git@github.com:tradingstrategy-ai/ethereum-blockchain-docker-compose.git
```

## Step 4: Setup environment and start base node with docker compose
You can read more with base node [github](https://github.com/base-org/node)

**Before start:**

1. Ensure you have an Ethereum L1 full node RPC available (not Base), and set OP_NODE_L1_ETH_RPC (in the .env.* file if using docker-compose). If running your own L1 node, it needs to be synced before Base will be able to fully sync.

2. Uncomment the line relevant to your network `.env.mainnet` under the 2 env_file keys in `docker-compose.yml.`
```
services:
  geth: # this is Optimism's geth client
    ...
    env_file:
      - .env.mainnet
  
  node: 
    ...
    env_file:
      - .env.mainnet
```

3. You can map a local data directory for op-geth by adding a volume mapping to the `docker-compose.yaml`:
```
services:
  geth: # this is Optimism's geth client
    ...
    volumes:
      - /base/data:/data
```
4. Update your Ethereum full not RPC to `.env.mainnet` 

5. We added github of base node in git submodule. You need run command to download [base node github](https://github.com/base-org/node)

`Command:`
```
cd /base/ethereum-blockchain-docker-compose/deps$
git submodule init
```

**Start base node with docker-compose**


Now, you can start base node by run docker compose

```
docker-compose up -d --force-recreate
```


## Step 5: Check base node [syncing](https://mainnet.base.org/)
Sync speed depends on your L1 node, as the majority of the chain is derived from data submitted to the L1. You can check your syncing status using the optimism_syncStatus RPC on the op-node container

Example:
```
echo Latest synced block behind by: $((($(date +%s)-$( \
  curl -d '{"id":0,"jsonrpc":"2.0","method":"optimism_syncStatus"}' \
  -H "Content-Type: application/json" http://localhost:7545 | \
  jq -r .result.unsafe_l2.timestamp))/60)) minutes
```

If you want to know latest block of your node. You can run command, you replace RPC: `https://mainnet.base.org/` to your node RPC

```
date; curl -sX POST -H "Content-Type: application/json" \
 -d '{"jsonrpc": "2.0", "method": "eth_blockNumber", "params": [], "id":1}' \
https://mainnet.base.org/ \
| jq -r ".result" | awk '{printf "%d\n", int($1)}'
```


### If base node data too big, you can prune data by this step:

- Stop both op-geth & op-node:
```
docker-compose stop
```
- Making sure the containers properly exited
```
docker-compose ps -a 
```
- Run prune command:
```
docker-compose run -d geth /app/geth snapshot prune-state --datadir=/data

stdout: [container id]
```
- Check the log for properly exiting the pruning
note: this will take several hours and may look like it's frozen at times. It's not frozen - just leave it until it finishes.
```
docker logs -f --tail 100 [container id]
```
-  Start the op-node and op-geth services again
```
docker-compose up -d
```


**You can read more about base in** ` https://docs.base.org/ ` 

**Github**: `https://github.com/base-org/node`