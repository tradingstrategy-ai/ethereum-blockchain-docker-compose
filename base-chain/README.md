
# Installation Notes
CHAINID: 8453

## Step 1:
Download snapshot from: 

``` 
wget -o - https://base-mainnet-archive-snapshots.s3.us-east-1.amazonaws.com/$(curl https://base-mainnet-archive-snapshots.s3.us-east-1.amazonaws.com/latest) 
```

We will get snapshot file: `base-mainnet-archive-1694415970.tar.gz`

## Step 2
Create folder mount
```
mkdir -p /base
```
Move snapshot file `base-mainnet-archive-1694415970.tar.gz` to `/base`
```
mv base-mainnet-archive-1694415970.tar.gz /base
```

Untar snapshot
```
tar -zxvf base-mainnet-archive-1694415970.tar.gz 
```


## Step3
Clone docker-compose:

```
git@github.com:tradingstrategy-ai/ethereum-blockchain-docker-compose.git
```

## Step 4
Run docker compose
```
cd ethereum-blockchain-docker-compose/base
docker-compose up -d --force-recreate
```

## Step 5
Check node sync:
```
echo Latest synced block behind by: $((($(date +%s)-$( \
  curl -d '{"id":0,"jsonrpc":"2.0","method":"optimism_syncStatus"}' \
  -H "Content-Type: application/json" http://localhost:7545 | \
  jq -r .result.unsafe_l2.timestamp))/60)) minutes
```

Check last block:
```
date; curl -sX POST -H "Content-Type: application/json" \
 -d '{"jsonrpc": "2.0", "method": "eth_blockNumber", "params": [], "id":1}' \
https://mainnet.base.org/ \
| jq -r ".result" | awk '{printf "%d\n", int($1)}'
```

### If you want to prune your node data:
- Stop both op-geth & op-node:
```
docker compose stop
```
- Making sure the containers properly exited
```
docker compose ps -a 
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
docker compose start
```


**You can read more about base in** ` https://docs.base.org/ ` 

**Github**: `https://github.com/base-org/node`