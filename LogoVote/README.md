# Logo Vote 2017

Vote a new logo for Taipei Ethereum Meetup with smart contracts!

Read the [general guideline](https://docs.google.com/document/d/1hHLMnYxf4SAOSwGolDjZ1gTDEXoJAuroYTO5kBttTUE) and this [technical document](https://docs.google.com/document/d/1ThfWKQFa9q2hSXl4_y_dFM1uF3hcP9iP8Xm8tfV567U/) for more detail.

## Developing

### install truffle

```
npm config set python python2.7
npm install -g ethereumjs-testrpc
npm install -g truffle
//
// visual studio 2015 build tools 
// npm install -g ethereumjs-testrpc --msvs_version=2015
// npm install -g truffle --msvs_version=2015
//
mkdir truffle && cd truffle
truffle init
```

###  test contract

```
testrpc &
truffle test
```