var LogoVote = artifacts.require('./LogoVote.sol')
var Vote = artifacts.require('./Vote.sol')

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
    var tx0
    return LogoVote.deployed().then(function (instance) {
      logoVote = instance
      return logoVote.registLogo(accounts[0], accounts[1], 'http://logo0')
    }).then(function (_tx0) {
      assert.isOk(_tx0)
      tx0 = _tx0
      return logoVote.getLogos.call()
    }).then(function (logos) {
      console.log(logos)
      assert.equal(logos.length, 1)
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


})