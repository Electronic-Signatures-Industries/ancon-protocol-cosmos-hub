# Ancon Protocol Cosmos Hub (Gaia) chain build
![image](https://user-images.githubusercontent.com/964052/)


## Running an Ancon Protocol v0.2.4 module with Gaia, Vega testnet

### Compile

> Note: Requires Go 1.17+

1. Clone `https://github.com/Electronic-Signatures-Industries/ancon-protocol-cosmos-hub`
2. Download Starport
3. Run `starport chain build`
4. Copy `go/bin/gaiad` to `/usr/local/bin`

### Running Your Own Full-Node

> Note: Requires Vega Upgrade to be live on testnet

1. Clean any existing files `rm -rf .gaia/`
2. Create keys or  use existing
   `gaiad keys add mykey -i --keyring-backend file`
3. Initialize
   `gaiad init mynode --chain-id vega-testnet`
4. Copy `app.toml` and `config.toml` to `.gaia/config`
5. Extract `gen.zip` to `.gaia/config/genesis.json`
6. Run `gaiad start --x-crisis-skip-assert-invariants`

### Staking information

Soon
