FROM debian:10

ENV NETWORK=main
ENV BSC_VERSION=v1.1.17

RUN apt-get update
RUN apt-get -y install wget unzip

RUN wget -S https://github.com/binance-chain/bsc/releases/download/${BSC_VERSION}/geth_linux

RUN chmod u+x geth_linux

RUN mv geth_linux /usr/bin/geth

# https://docs.binance.org/smart-chain/developer/fullnode.html
## mainet
RUN wget -S https://github.com/binance-chain/bsc/releases/download/${BSC_VERSION}/mainnet.zip
RUN unzip mainnet.zip

## testnet
# RUN wget https://github.com/binance-chain/bsc/releases/download/v1.1.0-beta/testnet.zip
# RUN unzip testnet.zip

# NODE P2P
#EXPOSE 30311/udp
#EXPOSE 30311/tcp

# pprof / metrics
#EXPOSE 6060/tcp

# HTTP based JSON RPC API
#EXPOSE 9545/tcp
# WebSocket based JSON RPC API
#EXPOSE 9546/tcp
# GraphQL API
#EXPOSE 9547/tcp

# Do not start any service with the default run
CMD geth version
