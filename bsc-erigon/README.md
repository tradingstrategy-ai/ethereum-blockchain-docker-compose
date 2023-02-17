Services needed

- `erigon` core
- `sentry` P2P client
- `downloaded` snapshot sync client
- `rpcdaemon` JSON-RPC and other APIs

# Command line help

`docker run tradingstrategy-ai/erigon:latest erigon --help`

# Startup

`docker compose up -d erigon sentry downloader rpcdaemon`

# Logs

`docker compose logs --tail=1000 erigon`

# CPU and load

`htop`

# Health check

```shell
curl --request GET 'http://localhost:8545/health' \
    --header 'X-ERIGON-HEALTHCHECK: min_peer_count1' \
    --header 'X-ERIGON-HEALTHCHECK: synced' \
    --header 'X-ERIGON-HEALTHCHECK: max_seconds_behind600' \
    | jq
```

# Check the latest block

Check the latest block:

```shell
curl \
    --location \
    --header 'Content-Type: application/json' \
    --data-raw '{"jsonrpc":"2.0","method":"eth_blockNumber","params": [],"id":1}' \
    http://127.0.0.1:8545 
```

Check the first block:

```shell
curl \
    --header 'Content-Type: application/json' \
    --data-raw '{"jsonrpc":"2.0","method":"eth_getBlockByNumber","params": ["0x1", false],"id":1}' \    
```

# Query historical receipts

[0xcA143Ce32Fe78f1f7019d7d551a6402fC5350c73 is PancakeSwap v2](https://tradingstrategy.ai/trading-view/binance/pancakeswap-v2).

TODO

```shell
curl  \
  -H "Content-Type: application/json" \
  --data '{"method":"eth_getLogs","params":[{"address": "0xcA143Ce32Fe78f1f7019d7d551a6402fC5350c73"}],"id":1,"jsonrpc":"2.0"}' \
  http://127.0.0.1:8545 
```

# Invalid request

Call a bad API:

curl \
    --header 'Content-Type: application/json' \
    --data-raw '{"jsonrpc":"2.0","method":"xxx","params": [],"id":1}' \
    http://127.0.0.1:8545 

# Caddy

- [Setting up a reverse proxy for Grafana](https://community.grafana.com/t/caddy-server-reverse-proxy-and-grafana-in-a-subdirectory/14071/2)