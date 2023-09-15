
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

