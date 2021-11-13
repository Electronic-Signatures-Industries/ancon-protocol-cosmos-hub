package gaia

import (
	sdk "github.com/cosmos/cosmos-sdk/types"
	"github.com/cosmos/cosmos-sdk/x/auth/ante"
	"github.com/cosmos/cosmos-sdk/x/auth/signing"
	feegrantkeeper "github.com/cosmos/cosmos-sdk/x/feegrant/keeper"
	wasmkeeper "github.com/cosmos/gaia/v6/x/wasm/keeper"
	"github.com/cosmos/gaia/v6/x/wasm/types"
	channelkeeper "github.com/cosmos/ibc-go/v2/modules/core/04-channel/keeper"
	ibcante "github.com/cosmos/ibc-go/v2/modules/core/ante"
)

// HandlerOptions extend the SDK's AnteHandler options by requiring the IBC
// channel keeper.
type HandlerOptions struct {
	ante.HandlerOptions

	IBCChannelkeeper channelkeeper.Keeper
}

func NewAnteHandler(
	ak ante.AccountKeeper, bankKeeper types.BankKeeper,
	sigGasConsumer ante.SignatureVerificationGasConsumer,
	signModeHandler signing.SignModeHandler,
	txCounterStoreKey sdk.StoreKey,
	channelKeeper channelkeeper.Keeper,
	feegrantKeeper feegrantkeeper.Keeper,
) sdk.AnteHandler {

	anteDecorators := []sdk.AnteDecorator{
		wasmkeeper.NewCountTXDecorator(txCounterStoreKey),
		ante.NewRejectExtensionOptionsDecorator(),
		ante.NewMempoolFeeDecorator(),
		ante.NewValidateBasicDecorator(),
		ante.NewTxTimeoutHeightDecorator(),
		ante.NewValidateMemoDecorator(ak),
		ante.NewConsumeGasForTxSizeDecorator(ak),
		ante.NewDeductFeeDecorator(ak, bankKeeper, feegrantKeeper),
		// SetPubKeyDecorator must be called before all signature verification decorators
		ante.NewSetPubKeyDecorator(ak),
		ante.NewValidateSigCountDecorator(ak),
		ante.NewSigGasConsumeDecorator(ak, sigGasConsumer),
		ante.NewSigVerificationDecorator(ak, signModeHandler),
		ante.NewIncrementSequenceDecorator(ak),
		ibcante.NewAnteDecorator(channelKeeper),
	}

	return sdk.ChainAnteDecorators(anteDecorators...)
}
