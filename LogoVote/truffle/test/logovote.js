const addressRegex = /^(0x)([A-Fa-f0-9]{2}){20}$/;
var LogoVote = artifacts.require('./LogoVote.sol')
var Vote = artifacts.require('./Vote.sol')
var Logo = artifacts.require('./Logo.sol')


contract('LogoVote', function (accounts) {
  it('LogoVote and Vote instance should be ok.', function () {
    var logoVoteInstance
    var voteInstance
    return LogoVote.deployed().then(function (instance) {
      logoVoteInstance = instance
      return logoVoteInstance.totalReward.call()
    }).then(function (balance) {
      assert.equal(balance.valueOf(), 0)
      return logoVoteInstance.vote.call()
    }).then(function (voteAddress) {
      assert.isOk(voteAddress)
      return Vote.at(voteAddress)
    }).then(function (instance) {
      voteInstance = instance
      assert.isOk(voteInstance)
      return voteInstance.totalSupply.call()
    }).then(function (totalSupply) {
      assert.equal(totalSupply.valueOf(), 10000)
    })
  })

  it('registLogo should be ok', function () {
    var logoVote
    return LogoVote.deployed().then(function (instance) {
      logoVote = instance
      return logoVote.registLogo(accounts[0], accounts[1], 'http://logo0')
    }).then(function (_tx0) {
      assert.isOk(_tx0)
      return logoVote.getLogos.call()
    }).then(function (logos) {
      // console.log(logos)
      assert.equal(logos.length, 1)
      assert.match(logos[0], addressRegex, 'logo address should be a 20 byte hex address');
      return Logo.at(logos[0])
    }).then(function (logo0) {
      assert.isOk(logo0)
      return logo0.author.call()
    }).then(function (author) {
      assert.equal(author, accounts[1], 'author address should be accounts[1]')
    })
  })

  it('isLogo should be ok', function () {
    var logoVote
    return LogoVote.deployed().then(function (instance) {
      logoVote = instance
      return Promise.all(
        [logoVote.registLogo(accounts[0], accounts[1], 'http://logo0'),
          logoVote.registLogo(accounts[1], accounts[2], 'http://logo1'),
          logoVote.registLogo(accounts[2], accounts[3], 'http://logo2')
        ])
    }).then(function (values) {
      assert.equal(values.length, 3)
      return logoVote.getLogos.call()
    }).then(function (logos) {
      return logoVote.isLogo.call(logos[0])
    }).then(function (_isLogoResult) {
      assert.isOk(_isLogoResult, 'isLogo shoule be ok')
      return logoVote.isLogo.call(0xdead)
    }).then(function (_isLogoResult) {
      assert.isNotOk(_isLogoResult, 'isLogo shoule not be ok')
    })
  })

  it('donate should be ok', function () {
    var logoVote
    return LogoVote.deployed().then(function (instance) {
      logoVote = instance
      // Sending Ether / Triggering the fallback function
      return logoVote.sendTransaction({
        from: accounts[0],
        value: web3.toWei(1.1, "ether")
      })
    }).then(function (_txr) {
      // console.log(_txr)
      assert.isOk(_txr)
      return logoVote.totalReward.call()
    }).then(function (_totalReward) {
      assert.equal(_totalReward.valueOf(), web3.toWei(1.1, "ether"))
      return Promise.all([logoVote.sendTransaction({
        from: accounts[1],
        value: web3.toWei(2.2, "ether")
      }), logoVote.sendTransaction({
        from: accounts[2],
        value: web3.toWei(3.3, "ether")
      })])
    }).then(function (txs) {
      assert.isOk(txs)
      return logoVote.totalReward.call()
    }).then(function (_totalReward) {
      assert.equal(_totalReward.valueOf(), web3.toWei(6.6, "ether"))
    })
  })


})