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
testrpc
truffle test
```