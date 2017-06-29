pragma solidity ^0.4.10;

import "truffle/DeployedAddresses.sol";
import "truffle/Assert.sol";
import "../contracts/LogoVote.sol";
import "../contracts/Vote.sol";
import "./helpers/LogoVoteMock.sol";
import "./helpers/ThrowProxy.sol";

contract TestLogoVote {

  ThrowProxy throwProxy;

  function testInitialUsingDeployedContract() {
    LogoVote logovote = LogoVote(DeployedAddresses.LogoVote());
    Vote vote = Vote(logovote.vote());

    Assert.equal(logovote.totalReward(), 0, "LogoVote should have 0 reward initially");
    Assert.equal(vote.totalSupply(), 100000, "Vote should have 10000 totalSupply initially");
    Assert.equal(vote.initialSupply(), 100000, "Vote should have 10000 initialSupply initially");
  }

  function testInitialEndBlock() {
     LogoVoteMock logovote = new LogoVoteMock();
     Assert.equal(logovote.endBlock() ,172800 + logovote.startBlock() , 'Should return correct block number');
  }

  function testIsAfterEndAndIsRespectTimeFrame() {
     LogoVoteMock logovote = new LogoVoteMock();
     logovote.setMockedBlockNumber(logovote.endBlock()-1);
     Assert.isTrue(logovote.isRespectTimeFrame() , 'Should return true');
     logovote.setMockedBlockNumber(logovote.endBlock()+1);
     Assert.isTrue(logovote.isAfterEnd() , 'Should return true');
  }


  // 
  // http://truffleframework.com/tutorials/testing-for-throws-in-solidity-tests
  // https://github.com/aragon/aragon-network-token/blob/master/test/helpers/ThrowProxy.sol
  // 
  //  Error: VM Exception while processing transaction: invalid opcode
  //
  // function testWhenClaimWinnerBeforeEndBlock() {
  //  TestLogoVote(throwProxy).throwsWhenClaimWinnderBeforeEndBlock();
  //  throwProxy.assertThrows("Should have thrown when vote is not over yet");
  // }

  //function throwsWhenClaimWinnderBeforeEndBlock() {
  //   LogoVoteMock logovote = new LogoVoteMock();
  //   logovote.setMockedBlockNumber(101);
  //   logovote.claimWinner();
  //}

  function testInitialWithNewVote() {
    Vote vote = new Vote();
    Assert.equal(vote.totalSupply(), 100000, "Vote should have 10000 totalSupply initially");
    Assert.equal(vote.initialSupply(), 100000, "Vote should have 10000 initialSupply initially");
  }

}