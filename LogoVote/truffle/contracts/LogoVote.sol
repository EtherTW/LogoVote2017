pragma solidity ^0.4.10;
import "./Vote.sol";
import "./Logo.sol";
import "./Pausable.sol";
import "./SafeMath.sol";
import "./Faucet.sol";

contract LogoVote is Pausable, SafeMath{

	Vote public vote;
	Faucet public faucet;
	Logo[] public logos;

	mapping (address => uint) backers;

	uint public votePerETH;
	uint public totalReward;
	uint public startBlock;
	uint public endBlock;
	address public winner;

	event ReceiveDonate(address addr, uint value);

	modifier respectTimeFrame() {
		if (block.number > endBlock) throw;
		_;
	}

	modifier afterEnd() {
		if (block.number < endBlock) throw;
		_;
	}

	function LogoVote() {
		vote = new Vote();
		faucet = new Faucet(vote);
		votePerETH = 10; // donate 0.1 ether to get 1 vote 
		totalReward = 0;
		startBlock = block.number;
		endBlock = startBlock + ( 20 * 24 * 60 * 60 / 15 ); //end in 20 days
	}

	function sendToFaucet(uint _amount) onlyOwner {
		if(!vote.transfer(faucet, _amount)) throw;
	}

	function registLogo(address _owner, address _author, string _metadatUrl) 
						onlyOwner respectTimeFrame returns (address) {
		Logo logoAddress = new Logo(_owner, _author, _metadatUrl);
		logos.push(logoAddress);
		return logoAddress;
	}

	function donate(address beneficiary) internal stopInEmergency respectTimeFrame {
		uint voteToSend = safeMul(msg.value, votePerETH)/(1 ether);
		if (!vote.transfer(beneficiary, voteToSend)) throw; 
		backers[beneficiary] = safeAdd(backers[beneficiary], msg.value);
		totalReward = safeAdd(totalReward, msg.value);

		ReceiveDonate(beneficiary, msg.value);
	}

	function withdrawDonates () onlyInEmergency {
		uint ethToSend = backers[msg.sender];
		if(ethToSend == 0) throw;
		if(this.balance < ethToSend) throw;
		backers[msg.sender] = 0;
		if(!msg.sender.send(ethToSend)) throw;
	}

	function claimReward (address _receiver) stopInEmergency afterEnd {
		if (msg.sender != winner) throw;
		if (!_receiver.send(this.balance)) throw;
	}

	function isLogo (address _logoAddress) constant returns (bool) {
		for (uint8 i = 0; i < logos.length; i++) {
			if (logos[i] == _logoAddress) return true;
		}
	}

	function claimWinner () onlyOwner afterEnd {
		winner = logos[0];
		for (uint8 i = 1; i < logos.length; i++) {
			if (vote.balanceOf(logos[i]) > vote.balanceOf(winner))
				winner = logos[i];
		} 
	}

	function () payable {
		if (block.number > endBlock) throw;
		donate(msg.sender);
	}
}