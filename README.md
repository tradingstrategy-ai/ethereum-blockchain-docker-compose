This repository contains Docker Compose file to run various EVM based blockchains.

# Ethereum mainnet 

* Based on the official [GoEthereum Docker image](https://hub.docker.com/r/ethereum/client-go)

* Network id: 1

* RPC Port: 8545

* Data volume: `./data/ethereum`

## Commands

Help: `docker-compose run ethereum --help`

Shell: (not available)

Build and run as daemon: `docker-compose up --build -d ethereum`

Restart: `docker-compose restart ethereum`

Logs: `docker-compose logs ethereum`

(todo) Show sync status: `docker-compose run ethereum attach http://127.0.0.1:8545 --exec "eth.syncing"` 

# Binance Smart Chain (BSC)

* Based on [this recipe](https://github.com/ServerContainers/bsc)

* Network id: 56

* RPC ports 9545 (HTTP), 9546 (Websockets)

* Data volume `./data/bsc`

* [Documentation](https://docs.binance.org/smart-chain/developer/fullnode.html)

* [Releases](https://github.com/binance-chain/bsc/releases)

Notes

* [Geth garbage collection disabled](https://github.com/ethereum/go-ethereum/issues/21865)

* [Snap sync enabled](https://github.com/binance-chain/bsc/releases/tag/v1.1.0-beta) as 1.1.0-beta release

## Commands

BSC geth might take a minute or two before it starts to respond to port 9545.
BSC logs seem to be very terse and you cannot get useful log output even with `-verbosity 5` - you cannot see from the logs if it is syncing or not. 

Help: `docker-compose run bsc /usr/bin/geth --help`

Shell: `docker-compose run bsc bash`

Build and run as daemon: `docker-compose up --build -d bsc`

Restart: `docker-compose restart bsc`

Logs: `docker-compose logs bsc`

Geth console: `docker-compose run bsc /usr/bin/geth attach http://127.0.0.1:9545`

Show sync status: `docker-compose exec bsc /usr/bin/geth attach http://127.0.0.1:9545 --exec "eth.syncing"` 

# Polygon

This Docker compose file runs Polygon (previously Matic) EVM node locally. The EVM network is also known as **Bor** and it is an Go Ethereum (geth) clone.

* Based on [the recipe by Chase Wright](https://chasewright.com/how-to-run-a-polygon-matic-mainnet-node/)

* Maps JSON-RPC to port `8546` to avoid conflict with any existing EVM, like Ethereum mainnet, running on the same server

TODO

