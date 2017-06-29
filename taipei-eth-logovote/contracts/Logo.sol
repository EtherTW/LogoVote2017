pragma solidity ^0.4.10;
import "./Ownable.sol";

contract wLogoVote {
	function claimReward(address _receiver);
}

contract Logo is Ownable{

	wLogoVote public logoVote;

	address public author;
	string public metadataUrl;

	event ReceiveTips(address _from, uint _value);

	function Logo(address _owner, address _author, string _metadatUrl){
		owner = _owner;
		author = _author;
		metadataUrl = _metadatUrl;
		logoVote = wLogoVote(msg.sender);
	}

	function tips() payable {
		ReceiveTips(msg.sender, msg.value);
		if(!author.send(msg.value)) throw;
	}

	function claimReward() onlyOwner {
		logoVote.claimReward(author);
	}

	function setMetadata(string _metadataUrl) onlyOwner {
		metadataUrl = _metadataUrl;
	}

	function () payable {
		tips();
	}
}