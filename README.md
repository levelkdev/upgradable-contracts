# Upgradable Contracts

This a general pattern for an upgradable dApp with a shared key value store. The `Coordinator` manages access to `PersistentStorage`, the shared storage for the dApp. Each contract registered with `PersistentStorage` has a key and is only allowed to write to state within the context of that key. The `Coordinator` itself can be upgraded to a new governance mechanism using `setCoordinator()`.

### Setup

Make sure you have the following installed globally:

node 8

TestRPC 6: `npm install -g ethereumjs-testrpc`

Then run `yarn install`

### Compile

Recompile contracts and build artifacts.

```
$ yarn compile
```

### Deploy

Deploy contracts to RPC provider at port `8546`.

```
$ yarn deploy
```

### Test

Run `yarn compile` before first test run, and after any changes to the `.sol` files

```
$ yarn test
```

Run `yarn test:coverage` to run with coverage reporting

### Deployment Setup

Add `secrets.json` to the project root

```
// secrets.json
{
  "mnemonic": "<some mnemonic>",
  "infura_apikey": "<your infura key>"
}
```

Go to https://iancoleman.github.io/bip39/, click "Generate". Add `BIP39 Mnemonic` to `"mnemonic"` value in `secrets.json`

Add address from the BIP39 page to MetaMask. Send it some rinkeby Ether, or get it from the faucet on https://www.rinkeby.io

Go to https://infura.io/register.html to register for Infura. Paste your API key into `"infura_apikey"` value in `secrets.json`

`yarn deploy-rinkeby` to deploy to rinkeby
