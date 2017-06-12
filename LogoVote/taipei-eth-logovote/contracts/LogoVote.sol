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
	mapping (address => bool) rewards;
	uint rewardClaimed;

	uint public votePerETH;
	uint public totalReward;
	uint public startBlock;
	uint public endBlock;
	address public winner;

	event ReceiveDonate(address addr, uint value);

	modifier respectTimeFrame() {
		if (!isRespectTimeFrame()) throw;
		_;
	}

	modifier afterEnd() {
		if (!isAfterEnd()) throw;
		_;
	}

	function LogoVote() {
		vote = new Vote();
		faucet = new Faucet(vote);
		votePerETH = 1000; // donate 0.001 ether to get 1 vote 
		totalReward = 0;
		startBlock = getBlockNumber();
		endBlock = startBlock + ( 30 * 24 * 60 * 60 / 15 ); //end in 30 days
		rewardClaimed = 0;
	}

	function sendToFaucet(uint _amount) onlyOwner {
		if(!vote.transfer(faucet, _amount)) throw;
	}

	function sendVote(address _to, uint _amount) onlyOwner afterEnd {
		if(!vote.transfer(_to, _amount)) throw;
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

	function claimReward (address _receiver) stopInEmergency afterEnd {
		if (!isLogo(msg.sender)) throw;
		if (rewards[msg.sender]) throw;
		if (rewardClaimed == logos.length) throw;
		uint amount = totalReward / safeMul(2, logos.length); // all logos share the 50% of rewards
		if (msg.sender == winner) {
			amount = safeAdd(amount, totalReward/2);
		}
		rewards[msg.sender] = true;
		rewardClaimed = safeAdd(rewardClaimed, 1);
		if (!_receiver.send(amount)) throw;
	}

	function isLogo (address _logoAddress) constant returns (bool) {
		for (uint8 i = 0; i < logos.length; i++) {
			if (logos[i] == _logoAddress) return true;
		}
	}

	function getLogos() constant returns (Logo[]) {
		return logos;
	}

	function claimWinner () onlyOwner afterEnd {
		if (isLogo(winner)) throw;
		winner = logos[0];
		for (uint8 i = 1; i < logos.length; i++) {
			if (vote.balanceOf(logos[i]) > vote.balanceOf(winner))
				winner = logos[i];
		} 
	}

	function cleanBalance () onlyOwner afterEnd {
		if (rewardClaimed >= logos.length || getBlockNumber() < endBlock + 43200) throw;
		if (!owner.send(this.balance)) throw;
	}

	function getBlockNumber() constant returns (uint) {
      return block.number;
    }

	function isAfterEnd() constant returns (bool) {
      return getBlockNumber() > endBlock;
    }

	function isRespectTimeFrame() constant returns (bool) {
		return getBlockNumber() < endBlock;
	}

	function () payable {
		if (isAfterEnd()) throw;
		donate(msg.sender);
	}
}