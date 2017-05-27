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
    Assert.equal(vote.initialSupply(), 10000, "Vote should have 10000 initialSupply initially");
  }

  function testInitialWithNewLogoVote() {
    LogoVote logovote = new LogoVote();
    Assert.equal(logovote.totalReward(), 0 , "LogoVote should have 0 reward initially");
  }

  function testInitialWithNewVote() {
    Vote vote = new Vote();
    Assert.equal(vote.totalSupply(), 10000, "Vote should have 10000 totalSupply initially");
    Assert.equal(vote.initialSupply(), 10000, "Vote should have 10000 initialSupply initially");
    // https://stackoverflow.com/questions/42783106/member-equal-is-not-available-in-typelibrary-assert
    // Member "equal" is not available in type(library Assert) outside of storage.
    // Assert.equal(vote.symbol(), "EthTaipei Logo", "Symbol should be \"EthTaipei Logo\"");
  }

}