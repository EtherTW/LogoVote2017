pragma solidity ^0.4.0;

contract Game{

	struct Option {
		uint totalGet;
		BetInfo[] betInfo;
	}

	struct BetInfo {
		address betAddress;
		uint amount;
	}

	Option[2] public options;
	uint public bettingTime;
	uint public totoalReward;
	uint public winner;
	bool public haveResult;

	Option tempOption;
	BetInfo tempBetInfo;

	// Stage 0: Create
	// Initialize
	function Game(uint _betTimePeriodInMinutes) {
		bettingTime = now + _betTimePeriodInMinutes * 1 minutes;
		haveResult = false;
	}

	// Stage 1: Betting
	function bet(uint _option) payable {
		if(now > bettingTime) throw;
		if(_option >= options.length) throw;
		options[_option].betInfo.push(BetInfo(msg.sender, msg.value));
		options[_option].totalGet += msg.value;
		totoalReward += msg.value;
	}

	// Stage 2: Getting Result
	function getResult() {
		if(now < bettingTime) throw;
		if(haveResult) throw;
		winner = 1;
		haveResult = true;
	}

	// Stage 3: Dispatch the reward
	function dispatch() {
		if(!haveResult) throw;
		if(winner >= options.length) throw;

		for(var i = 0; i < options[winner].betInfo.length; i++){
			var receiver = options[winner].betInfo[i].betAddress;
			var value = totoalReward * options[winner].betInfo[i].amount / options[winner].totalGet;
			if(!receiver.send(value)) throw;
		}
	}
}