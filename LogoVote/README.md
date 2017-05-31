# Logo Vote 2017

Vote a new logo for Taipei Ethereum Meetup with smart contracts!

Read the [general guideline](https://docs.google.com/document/d/1hHLMnYxf4SAOSwGolDjZ1gTDEXoJAuroYTO5kBttTUE) and this [technical document](https://docs.google.com/document/d/1ThfWKQFa9q2hSXl4_y_dFM1uF3hcP9iP8Xm8tfV567U/) for more detail.

## Developing

### Install truffle

```
npm config set python python2.7
npm install -g ethereumjs-testrpc
npm install -g truffle
//
// visual studio 2015 build tools 
// npm install -g ethereumjs-testrpc --msvs_version=2015
// npm install -g truffle --msvs_version=2015
//
mkdir taipei-eth-logovote && cd taipei-eth-logovote 
truffle init
```

### Test LogoVote contract

```
testrpc &
cd taipei-eth-logovote && npm install
truffle test
```

### LogoVote/Migrations contract deployment on kovan/rinkeby network

* [Kovan Example] LogoVote contract https://kovan.etherscan.io/address/0x9271ffbd17d190a55298be91cc003a737c9d8181
* [Kovan Example] Migrations contract https://kovan.etherscan.io/address/0x6a00679105767b16196730808017af25d6b83545
* [Rinkeby Example] LogoVote contract https://rinkeby.etherscan.io/address/0xb78dcaed43a4e04911b0aa3a2fb297d33ebd90b0
* [Rinkeby Example] Migrations contract https://rinkeby.etherscan.io/address/0x29a246d2d1c3fbd21972588f601f70766da7a024
* HD wallet derivation path = "m/44'/60'/0'/0/" https://github.com/ethereum/EIPs/issues/84
* mnemonic: BIP39 https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki
* Infura API https://infura.io/docs/

```
cd taipei-eth-logovote
TEST_MNEMONIC="kovan foo bar blah ..."
truffle migrate --network kovan --verbose-rpc
TEST_MNEMONIC="rinkeby foo bar blah ..."
truffle migrate --network rinkeby --verbose-rpc
// Windows
// $env:TEST_MNEMONIC="kovan foo bar blah ..." ; truffle migrate --network kovan --verbose-rpc
// $env:TEST_MNEMONIC="rinkeby foo bar blah ..." ; truffle migrate --network rinkeby --verbose-rpc
```