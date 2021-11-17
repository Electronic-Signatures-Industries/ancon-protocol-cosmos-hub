module github.com/cosmos/gaia/v5

go 1.16

require (
	github.com/Electronic-Signatures-Industries/ancon-protocol v0.0.0-20211117210418-f661283dddd8
	github.com/cosmos/cosmos-sdk v0.44.3
	github.com/gorilla/mux v1.8.0
	github.com/gravity-devs/liquidity v1.2.9
	github.com/grpc-ecosystem/grpc-gateway/v2 v2.6.0 // indirect
	github.com/pkg/errors v0.9.1
	github.com/rakyll/statik v0.1.7
	github.com/spf13/cast v1.4.1
	github.com/spf13/cobra v1.2.1
	github.com/stretchr/testify v1.7.0
	github.com/tendermint/spm v0.1.7
	github.com/tendermint/tendermint v0.34.14
	github.com/tendermint/tm-db v0.6.4
)

replace google.golang.org/grpc => google.golang.org/grpc v1.33.2

replace github.com/tendermint/tendermint => github.com/tendermint/tendermint v0.34.13

replace github.com/gogo/protobuf => github.com/regen-network/protobuf v1.3.3-alpha.regen.1

replace github.com/cosmos/cosmos-sdk => github.com/cosmos/cosmos-sdk v0.42.10
