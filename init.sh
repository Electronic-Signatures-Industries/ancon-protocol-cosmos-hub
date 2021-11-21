#!/bin/bash

KEY="mykey"
CHAINID="ancon"
MONIKER="tensta"
KEYRING="test"
# KEYALGO="eth_secp256k1"
LOGLEVEL="info"
# to trace evm
# TRACE="--trace"
MNEMONIC="soda comic bachelor scheme absent embrace case toddler medal scrub obtain glad"
MNEMONICA="lend lock kit kiss walnut flower expect text upset nut arrive hub waste stairs climb neither must crowd harvest network wife lizard shiver obtain"
MNEMONICB="concert negative cry purse shed chest daughter knock success august axis capable tomato apple seven define gain allow carbon science confirm portion mountain combine"
# validate dependencies are installed
command -v jq > /dev/null 2>&1 || { echo >&2 "jq not installed. More info: https://stedolan.github.io/jq/download/"; exit 1; }

# remove existing daemon and client
rm -rf ~/.ancond*

~/go/bin/ancond config keyring-backend $KEYRING
~/go/bin/ancond config chain-id $CHAINID

# if $KEY exists it should be deleted
(echo $MNEMONICA) | ~/go/bin/ancond keys add $KEY --keyring-backend $KEYRING --recover  --home ~/.ancond
#(echo $MNEMONICA)| ~/go/bin/ancond keys add alice --keyring-backend $KEYRING --algo $KEYALGO --recover
#(echo $MNEMONICB)| ~/go/bin/ancond keys add bob --keyring-backend $KEYRING --algo $KEYALGO --recover

# Set moniker and chain-id for Ethermint (Moniker can be anything, chain-id must be an integer)
~/go/bin/ancond init $MONIKER --chain-id $CHAINID  --home ~/.ancond

# Change parameter token denominations to aphoton
cat $HOME/.ancond/config/genesis.json | jq '.app_state["staking"]["params"]["bond_denom"]="uatom"' > $HOME/.ancond/config/tmp_genesis.json && mv $HOME/.ancond/config/tmp_genesis.json $HOME/.ancond/config/genesis.json
cat $HOME/.ancond/config/genesis.json | jq '.app_state["crisis"]["constant_fee"]["denom"]="uatom"' > $HOME/.ancond/config/tmp_genesis.json && mv $HOME/.ancond/config/tmp_genesis.json $HOME/.ancond/config/genesis.json
cat $HOME/.ancond/config/genesis.json | jq '.app_state["gov"]["deposit_params"]["min_deposit"][0]["denom"]="uatom"' > $HOME/.ancond/config/tmp_genesis.json && mv $HOME/.ancond/config/tmp_genesis.json $HOME/.ancond/config/genesis.json
cat $HOME/.ancond/config/genesis.json | jq '.app_state["mint"]["params"]["mint_denom"]="uatom"' > $HOME/.ancond/config/tmp_genesis.json && mv $HOME/.ancond/config/tmp_genesis.json $HOME/.ancond/config/genesis.json

# increase block time (?)
# cat $HOME/.ancond/config/genesis.json | jq '.consensus_params["block"]["time_iota_ms"]="1000"' > $HOME/.ancond/config/tmp_genesis.json && mv $HOME/.ancond/config/tmp_genesis.json $HOME/.ancond/config/genesis.json

# Set gas limit in genesis
# cat $HOME/.ancond/config/genesis.json | jq '.consensus_params["block"]["max_gas"]="10000000"' > $HOME/.ancond/config/tmp_genesis.json && mv $HOME/.ancond/config/tmp_genesis.json $HOME/.ancond/config/genesis.json


# Allocate genesis accounts (cosmos formatted addresses)
~/go/bin/ancond add-genesis-account cosmos1ngfkr3wzm7a890kuweuwezg62jzydsprl7dmv8 100000000000000000000000000uatom --keyring-backend $KEYRING  --home ~/.ancond
~/go/bin/ancond add-genesis-account $KEY 100000000000000000000000000uatom --keyring-backend $KEYRING  --home ~/.ancond
# Sign genesis transaction
~/go/bin/ancond gentx $KEY 1000000000000000000000uatom  --keyring-backend $KEYRING --chain-id $CHAINID  --home ~/.ancond

# Collect genesis tx
~/go/bin/ancond collect-gentxs  --home ~/.ancond

# Run this to ensure everything worked and that the genesis file is setup correctly
~/go/bin/ancond validate-genesis  --home ~/.ancond

if [[ $1 == "pending" ]]; then
  echo "pending mode is on, please wait for the first block committed."
fi

cp app.toml $HOME/.ancond/config/app.toml

cp config.toml $HOME/.ancond/config/config.toml


#~/go/bin/ancond keys show alice | echo
#~/go/bin/ancond keys show bob | echo


# Start the node (remove the --pruning=nothing flag if historical queries are not needed)
~/go/bin/ancond start --log_level $LOGLEVEL --trace

#~/go/bin/ancond tx bank send ethm1jrclh4kgf3467e9aueudn9fflaz04mftahgun3 ancon1x23pcxakulpq74r7jv948kk90apv6f0kpzgp83 10000aphoton
#~/go/bin/ancond tx bank send ethm1jrclh4kgf3467e9aueudn9fflaz04mftahgun3 ethm1yf7eqee4l9hen2g3q799j92k638e98lfq84635 10000aphoton