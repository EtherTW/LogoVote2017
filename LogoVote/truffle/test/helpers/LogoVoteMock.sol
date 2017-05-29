pragma solidity ^0.4.10;

import '../../contracts/LogoVote.sol';

// @dev LogoVoteMock mocks current block number

contract LogoVoteMock is LogoVote {

  uint mock_blockNumber = 1;

  function LogoVoteMock () LogoVote() {

  }

  function getBlockNumber() constant returns (uint) {
    return mock_blockNumber;
  }

  function setMockedBlockNumber(uint _b) {
    mock_blockNumber = _b;
  }

}