# Ancon Protocol - Tensta testnet  deprecated!

<img  src="https://raw.githubusercontent.com/Electronic-Signatures-Industries/ancon-protocol/main/specs/AnconProtocoLogo.jpg" align="center" width="250" />

## Running an Ancon Protocol v0.3.0-rc.1 aka Data Contract

### Compile

> Note: Requires Go 1.17+

1. Clone `https://github.com/Electronic-Signatures-Industries/ancon-protocol-cosmos-hub`
2. Download Starport
3. Run `starport chain build`
4. Copy `go/bin/ancond` to `/usr/local/bin/ancond`

### Running Your Own Full-Node

> Note: Unstable as we are making updates and learning the chain ops process

1. Clean any existing files `rm -rf .ancon/`
2. Add `04aefa14511fa744965b95221528585351d74959@ancon.did.pa:26656` to config.toml
3. Download genesis.json and unpack data folder
4. Run `ancond start`

### Staking information

Soon
