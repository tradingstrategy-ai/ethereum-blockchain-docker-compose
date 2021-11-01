# Polygon

Steps to run a full polygon node.

- Proof of Stake node - called Heimdall
- REST API server - also called Heimdall
- EVM node - called Bor.

## Prepare Docker Images 

### Create Heimdall Docker build

```
#### Make a directory to work in
mkdir -p /bsc/polygon/data/heimdall
cd /bsc/polygon/data/github

#### Clone the repo
git clone https://github.com/maticnetwork/heimdall.git
cd heimdall

#### Checkout the mainnet release version
git checkout v0.2.3

#### Copy the Dockerfile up a directory
cp docker/Dockerfile .

#### Edit their shitty Dockerfile
sed -i 's#./logs#/root/heimdall/logs#' Dockerfile

#### Build the docker image
docker build --tag heimdall:latest .

push docker to registry

### Create Heimdall Docker build 

#### Re-use our github folder
cd /data/github

#### Clone the repo
git clone https://github.com/maticnetwork/bor.git
cd bor

#### This is the current recommended version
git checkout v0.2.9

#### Build the docker image
docker build --tag bor:latest .

#### Make a directory for bor data
mkdir -p /data/volumes/bor

#### We need to download the genesis.json file FIRST this time
wget https://raw.githubusercontent.com/maticnetwork/launch/master/mainnet-v1/without-sentry/bor/genesis.json -O /data/volumes/bor/genesis.json

#### Initialize bor with genesis file
docker run -it -v /data/volumes/bor:/datadir bor:latest bor --datadir /datadir init /datadir/genesis.json

```


## Heimdall deploy
```
### Make a directory for heimdall data
mkdir -p /bsc/polygon/data/volumes/heimdall

### Init configs and stuff
docker run -it --name=heimdall -v /bsc/polygon/data/volumes/heimdall:/root/.heimdalld servatj/heimdall:latest heimdalld init

### Overwrite the genesis.json file with the mainnet launch genesis.json file
wget https://raw.githubusercontent.com/maticnetwork/launch/master/mainnet-v1/without-sentry/heimdall/config/genesis.json -O /bsc/polygon/data/volumes/heimdall/config/genesis.json

### modify config files
cd /bsc/polygon/data/volumes/heimdall/config/

allow cors = [","]

seeds
"f4f605d60b8ffaaf15240564e58a81103510631c@159.203.9.164:26656,4fb1bc820088764a564d4f66bba1963d47d82329@44.232.55.71:26656"

```

### Snapshot 

```
wget -c https://matic-blockchain-snapshots.s3-accelerate.amazonaws.com/matic-mainnet/heimdall-snapshot-2021-09-24.tar.gz -O - | tar -xz -C /bsc/polygon/data/volumes/heimdall/data

docker run -it -p "26656:26656" -p "26657:26657" -v /data/volumes/heimdall:/root/.heimdalld heimdall:latest heimdalld start

docker run -itd --name=heimdall -p "26656:26656" -p "26657:26657" -v /bsc/polygon/data/volumes/heimdall:/root/.heimdalld servatj/heimdall:latest heimdalld start

```

## BOR deploy

```
mkdir -p /bss/polygon/data/volumes/bor

wget https://raw.githubusercontent.com/maticnetwork/launch/master/mainnet-v1/without-sentry/bor/genesis.json -O /bsc/polygon/data/volumes/bor/genesis.json

docker run -it --name=bor -v /bsc/polygon/data/volumes/bor:/datadir bor:latest bor --datadir /datadir init /datadir/genesis.json

wget -c https://matic-blockchain-snapshots.s3-accelerate.amazonaws.com/matic-mainnet/bor-pruned-snapshot-2021-10-11.tar.gz -O - | tar -xz -C /bsc/polygon/data/volumes/bor/bor/chaindata
```






