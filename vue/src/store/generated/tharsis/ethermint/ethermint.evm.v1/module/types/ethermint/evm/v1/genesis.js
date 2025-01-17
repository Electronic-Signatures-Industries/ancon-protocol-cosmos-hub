/* eslint-disable */
import { Params, State } from "../../../ethermint/evm/v1/evm";
import { Writer, Reader } from "protobufjs/minimal";
export const protobufPackage = "ethermint.evm.v1";
const baseGenesisState = {};
export const GenesisState = {
    encode(message, writer = Writer.create()) {
        for (const v of message.accounts) {
            GenesisAccount.encode(v, writer.uint32(10).fork()).ldelim();
        }
        if (message.params !== undefined) {
            Params.encode(message.params, writer.uint32(18).fork()).ldelim();
        }
        return writer;
    },
    decode(input, length) {
        const reader = input instanceof Uint8Array ? new Reader(input) : input;
        let end = length === undefined ? reader.len : reader.pos + length;
        const message = { ...baseGenesisState };
        message.accounts = [];
        while (reader.pos < end) {
            const tag = reader.uint32();
            switch (tag >>> 3) {
                case 1:
                    message.accounts.push(GenesisAccount.decode(reader, reader.uint32()));
                    break;
                case 2:
                    message.params = Params.decode(reader, reader.uint32());
                    break;
                default:
                    reader.skipType(tag & 7);
                    break;
            }
        }
        return message;
    },
    fromJSON(object) {
        const message = { ...baseGenesisState };
        message.accounts = [];
        if (object.accounts !== undefined && object.accounts !== null) {
            for (const e of object.accounts) {
                message.accounts.push(GenesisAccount.fromJSON(e));
            }
        }
        if (object.params !== undefined && object.params !== null) {
            message.params = Params.fromJSON(object.params);
        }
        else {
            message.params = undefined;
        }
        return message;
    },
    toJSON(message) {
        const obj = {};
        if (message.accounts) {
            obj.accounts = message.accounts.map((e) => e ? GenesisAccount.toJSON(e) : undefined);
        }
        else {
            obj.accounts = [];
        }
        message.params !== undefined &&
            (obj.params = message.params ? Params.toJSON(message.params) : undefined);
        return obj;
    },
    fromPartial(object) {
        const message = { ...baseGenesisState };
        message.accounts = [];
        if (object.accounts !== undefined && object.accounts !== null) {
            for (const e of object.accounts) {
                message.accounts.push(GenesisAccount.fromPartial(e));
            }
        }
        if (object.params !== undefined && object.params !== null) {
            message.params = Params.fromPartial(object.params);
        }
        else {
            message.params = undefined;
        }
        return message;
    },
};
const baseGenesisAccount = { address: "", code: "" };
export const GenesisAccount = {
    encode(message, writer = Writer.create()) {
        if (message.address !== "") {
            writer.uint32(10).string(message.address);
        }
        if (message.code !== "") {
            writer.uint32(18).string(message.code);
        }
        for (const v of message.storage) {
            State.encode(v, writer.uint32(26).fork()).ldelim();
        }
        return writer;
    },
    decode(input, length) {
        const reader = input instanceof Uint8Array ? new Reader(input) : input;
        let end = length === undefined ? reader.len : reader.pos + length;
        const message = { ...baseGenesisAccount };
        message.storage = [];
        while (reader.pos < end) {
            const tag = reader.uint32();
            switch (tag >>> 3) {
                case 1:
                    message.address = reader.string();
                    break;
                case 2:
                    message.code = reader.string();
                    break;
                case 3:
                    message.storage.push(State.decode(reader, reader.uint32()));
                    break;
                default:
                    reader.skipType(tag & 7);
                    break;
            }
        }
        return message;
    },
    fromJSON(object) {
        const message = { ...baseGenesisAccount };
        message.storage = [];
        if (object.address !== undefined && object.address !== null) {
            message.address = String(object.address);
        }
        else {
            message.address = "";
        }
        if (object.code !== undefined && object.code !== null) {
            message.code = String(object.code);
        }
        else {
            message.code = "";
        }
        if (object.storage !== undefined && object.storage !== null) {
            for (const e of object.storage) {
                message.storage.push(State.fromJSON(e));
            }
        }
        return message;
    },
    toJSON(message) {
        const obj = {};
        message.address !== undefined && (obj.address = message.address);
        message.code !== undefined && (obj.code = message.code);
        if (message.storage) {
            obj.storage = message.storage.map((e) => e ? State.toJSON(e) : undefined);
        }
        else {
            obj.storage = [];
        }
        return obj;
    },
    fromPartial(object) {
        const message = { ...baseGenesisAccount };
        message.storage = [];
        if (object.address !== undefined && object.address !== null) {
            message.address = object.address;
        }
        else {
            message.address = "";
        }
        if (object.code !== undefined && object.code !== null) {
            message.code = object.code;
        }
        else {
            message.code = "";
        }
        if (object.storage !== undefined && object.storage !== null) {
            for (const e of object.storage) {
                message.storage.push(State.fromPartial(e));
            }
        }
        return message;
    },
};
