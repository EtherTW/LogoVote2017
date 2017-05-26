pragma solidity ^0.4.8;

import "truffle/DeployedAddresses.sol";
import "truffle/Assert.sol";
import "../contracts/LogoVote.sol";
import "../contracts/Vote.sol";

contract TestLogoVote {
  
  function testInitialUsingDeployedContract() {
    LogoVote logovote = LogoVote(DeployedAddresses.LogoVote());
    Vote vote = Vote(logovote.vote());

    Assert.equal(logovote.totalReward(), 0, "LogoVote should have 0 reward initially");
    Assert.equal(vote.totalSupply(), 10000, "Vote should have 10000 totalSupply initially");
  }

  function testInitialWithNewLogoVote() {
    LogoVote logovote = new LogoVote();
    Assert.equal(logovote.totalReward(), 0 , "LogoVote should have 0 reward initially");
  }

  function testInitialWithNewVote() {
    Vote vote = new Vote();
    Assert.equal(vote.totalSupply(), 10000, "Vote should have 10000 totalSupply initially");
  }

}