# Setup arbitrum node

## Step 1:
Download snapshot from: 
`https://snapshot.arbitrum.io/mainnet/nitro.tar`

We will get snapshot file: `Arbitrum.tar.lz4`

## Step 2
Create folder mount
```
mkdir -p /arbitrum-node/data
```
Move snapshot file `Arbitrum.tar.lz4` to `/arbitrum-node/data`
```
mv Arbitrum.tar.lz4 /arbitrum-node/data
```

## Step3
Clone docker-compose:

```
git@github.com:tradingstrategy-ai/ethereum-blockchain-docker-compose.git
```

## Step 4
Run docker compose
```
cd ethereum-blockchain-docker-compose/arbitrum
docker-compose up 
```

We will get error and docker compose stop:

```
ERROR[12-24|16:17:37.141] error initializing database              err="no --init.* mode supplied and chain data not in expected directory"
```

## Step 5
Remove l2chaindata folder
```
cd /arbitrum-node/data/nitro
```
```
mv l2chaindata/ l2chaindata.new
```

## Step 6: Copy snapshot data to main directory
```
mv /arbitrum-node/data/nitro/snapshot/* /arbitrum-node/data/nitro/
```

## Step 7: Disable config snapshot:
```
vim ethereum-blockchain-docker-compose/arbitrum/docker-compose.yml
```
Comment out:
```
--init.url=https://snapshot.arbitrum.io/mainnet/nitro.tar
```

## Step 8: Run arbitrum node:

```
docker-compose up -d --force-recreate
```

