# Erigon snapshots

We have scripts to create a snapshot of Erigon installation and
distribute it through Storj. 

[First read this BNB Chain snapshot blog post](https://tradingstrategy.ai/blog/bnb-chain-erigon-snapshot)
for more colour of the issue.

We use .tar.zst (Zstd compressed) [archive format](https://stackoverflow.com/a/75483439/315168).

Stop Erigon Dockers.

```shell
docker compose stop
```

Set up Storj account or get the keys on their website.

Copy and modify the example [compress-snapshot.sh](../bsc-erigon/compress-snapshot.sh) script.
It's small so you can simply paste it to the terminal.

Run snapshot script.

Restart Erigon Dockers.

```shell
docker compose up -d erigon
```

Copy and modify the example [upload-snapshot.sh](../bsc-erigon/upload-snapshot.sh) script

Run upload script.
It's small so you can simply paste it to the terminal.

# Further reading

- [Blog post](https://tradingstrategy.ai/blog/bnb-chain-erigon-snapshot)

- [Storj uplink documentation](https://docs.storj.io/dcs/downloads/download-uplink-cli)

