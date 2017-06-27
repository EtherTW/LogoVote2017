# Logo Vote 2017

Vote a new logo for Taipei Ethereum Meetup with smart contracts!

Read the [general guideline](https://docs.google.com/document/d/1hHLMnYxf4SAOSwGolDjZ1gTDEXoJAuroYTO5kBttTUE) and this [technical document](https://docs.google.com/document/d/1ThfWKQFa9q2hSXl4_y_dFM1uF3hcP9iP8Xm8tfV567U/) for more detail.

## Usage
### Two ways to get vote
- donate to the LogoVote by send ethers to LogoVote address
  - 0.001 ether get 1 vote
  - all the funds will be the reward to the winner (need discussion)
- get from faucet by send 0 ether transaction to Faucet address
  - it will give 1 vote to your ethereum account
  - it will fail if you send the ethers to faucet, and send back all the ethers

### Vote to the Logos
- by transfer vote to the logo address
- ERC20 functions
- any ether send to the logo address will be transfer to the author’s account (like tips), use it carefully.
- you can check if the logo address is valid or not in LogoVote contract

### Deploy
- Deploy LogoVote.sol, it will automatically create Vote and Faucet contract.
- Donate start.
- Owner call the sendToFaucet function with amount, then Faucet is available.
- Owner call the RegistLogo function for each logo.
- Voting start.
- End in 86400 blocks. (about 20 days)

### Owner’s ability (and only owner can do)
- dispatch the vote to the Faucet.
- add the new logo to the contract.
- end the vote by claimWinner() function.
0 stop the contract if in emergency.
- backer can get back their funds (donate) in emergency.
- release the emergency situation

### FAQ
1. RegistLogo 可以給一個範例嗎?

  Call the registLogo() in LogoVote contract with three parameters
only the owner of the LogoVote sc can do it.
The function will create a Logo smart contract for the logo. The first parameter is the address of owner who owned the logo smart contract.
The second parameter is the author’s address, the competition reward and the tips for the logo will be send to author’s address directly.
final parameter is for the logo’s metadata, give it a URL. Or using IPFS to store it in decentralized storage.

2. Release 是做什麼用的?

- release the emergency situation
- see the owner’s ability 4&5

3. 用哪一個 command 來 Donate?

  donate by send ether’s to the LogoVote’s address.

### Ropsten TestNet on address
```
https://ropsten.etherscan.io/address/0x4720969735e6495cfe1029e5638f22f563079d9e#
```

## Address of mainnet
### Main Contract
```
0x3Ab1d534Bb477f516817eFaAf0B569f419b8e292
```

### Faucet
```
0x5041bfBa3DEB602d794F6CF6C3Db50D572912c40
```

### TLV token
```
0x795a9bFa0B30b92eFE663cBfbEC1656b6378748E
```

### Start / End Block
```
3867102 / 4039902
```

## Address on Kovan testnet

### LogoVote (main contract)
```
0xc9e3118332E08cdb05938d2BEDfA9f9BA3874Dc2
```
(update by mingder) LogoVote is deployed to Ropsten TestNet on address:
`0x4720969735e6495CFE1029e5638F22F563079d9E` (obsolete)舊版, 放棄使用

### Vote (ERC20 Token)
```
0xEbe2B44e72682CAcD5A53B2869cf52f0eA451220
```
(on Rosten Test Net on address: `0x94b717C56a2b20B898Ab418b5AE8216AB737C2d8` (obsolete)舊版, 放棄使用

`https://ropsten.etherscan.io/token/0x13e4f3d6a0edf9a8a0106bb86baae4c388ba6081?a=0x94b717c56a2b20b898ab418b5ae8216ab737c2d8` (舊版, 放棄使用)

### Vote Faucet
```
0x8dF2248a671378D70006a14d3f6Ba28Aa4B02007
```

## ABI

### LogoVote
```
[{"constant":true,"inputs":[],"name":"endBlock","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"isAfterEnd","outputs":[{"name":"","type":"bool"}],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"getLogos","outputs":[{"name":"","type":"address[]"}],"payable":false,"type":"function"},{"constant":true,"inputs":[{"name":"","type":"uint256"}],"name":"logos","outputs":[{"name":"","type":"address"}],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"_owner","type":"address"},{"name":"_author","type":"address"},{"name":"_metadatUrl","type":"string"}],"name":"registLogo","outputs":[{"name":"","type":"address"}],"payable":false,"type":"function"},{"constant":false,"inputs":[],"name":"claimWinner","outputs":[],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"getBlockNumber","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"startBlock","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"},{"constant":false,"inputs":[],"name":"getFunds","outputs":[],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"votePerETH","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"},{"constant":true,"inputs":[{"name":"_logoAddress","type":"address"}],"name":"isLogo","outputs":[{"name":"","type":"bool"}],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"vote","outputs":[{"name":"","type":"address"}],"payable":false,"type":"function"},{"constant":false,"inputs":[],"name":"emergencyStop","outputs":[],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"_amount","type":"uint256"}],"name":"sendToFaucet","outputs":[],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"totalReward","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"stopped","outputs":[{"name":"","type":"bool"}],"payable":false,"type":"function"},{"constant":false,"inputs":[],"name":"cleanBalance","outputs":[],"payable":false,"type":"function"},{"constant":false,"inputs":[],"name":"release","outputs":[],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"owner","outputs":[{"name":"","type":"address"}],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"isRespectTimeFrame","outputs":[{"name":"","type":"bool"}],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"_receiver","type":"address"}],"name":"claimReward","outputs":[],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"faucet","outputs":[{"name":"","type":"address"}],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"winner","outputs":[{"name":"","type":"address"}],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"newOwner","type":"address"}],"name":"transferOwnership","outputs":[],"payable":false,"type":"function"},{"inputs":[],"payable":false,"type":"constructor"},{"payable":true,"type":"fallback"},{"anonymous":false,"inputs":[{"indexed":false,"name":"addr","type":"address"},{"indexed":false,"name":"value","type":"uint256"}],"name":"ReceiveDonate","type":"event"}]
```

### Logo
```
[{"constant":false,"inputs":[],"name":"tips","outputs":[],"payable":true,"type":"function"},{"constant":true,"inputs":[],"name":"owner","outputs":[{"name":"","type":"address"}],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"_metadataUrl","type":"string"}],"name":"setMetadata","outputs":[],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"author","outputs":[{"name":"","type":"address"}],"payable":false,"type":"function"},{"constant":false,"inputs":[],"name":"claimReward","outputs":[],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"metadataUrl","outputs":[{"name":"","type":"string"}],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"logoVote","outputs":[{"name":"","type":"address"}],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"newOwner","type":"address"}],"name":"transferOwnership","outputs":[],"payable":false,"type":"function"},{"inputs":[{"name":"_owner","type":"address"},{"name":"_author","type":"address"},{"name":"_metadatUrl","type":"string"}],"payable":false,"type":"constructor"},{"payable":true,"type":"fallback"},{"anonymous":false,"inputs":[{"indexed":false,"name":"_from","type":"address"},{"indexed":false,"name":"_value","type":"uint256"}],"name":"ReceiveTips","type":"event"}]
```

### Vote
Using ERC20 standard is enough, or use below Abi
```
[{"constant":true,"inputs":[],"name":"name","outputs":[{"name":"","type":"string"}],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"_spender","type":"address"},{"name":"_value","type":"uint256"}],"name":"approve","outputs":[{"name":"","type":"bool"}],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"totalSupply","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"_from","type":"address"},{"name":"_to","type":"address"},{"name":"_value","type":"uint256"}],"name":"transferFrom","outputs":[{"name":"","type":"bool"}],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"decimals","outputs":[{"name":"","type":"uint8"}],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"initialSupply","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"},{"constant":true,"inputs":[{"name":"_address","type":"address"}],"name":"balanceOf","outputs":[{"name":"balance","type":"uint256"}],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"symbol","outputs":[{"name":"","type":"string"}],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"_to","type":"address"},{"name":"_value","type":"uint256"}],"name":"transfer","outputs":[{"name":"","type":"bool"}],"payable":false,"type":"function"},{"constant":true,"inputs":[{"name":"_owner","type":"address"},{"name":"_spender","type":"address"}],"name":"allowance","outputs":[{"name":"remaining","type":"uint256"}],"payable":false,"type":"function"},{"inputs":[],"payable":false,"type":"constructor"},{"anonymous":false,"inputs":[{"indexed":true,"name":"from","type":"address"},{"indexed":true,"name":"to","type":"address"},{"indexed":false,"name":"value","type":"uint256"}],"name":"Transfer","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"name":"owner","type":"address"},{"indexed":true,"name":"spender","type":"address"},{"indexed":false,"name":"value","type":"uint256"}],"name":"Approval","type":"event"}]
```

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