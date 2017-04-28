pragma solidity ^0.4.0;

contract MyToken{

	mapping (address => uint) public balanceOf;
	uint public totalSupply;
	address public bank;
	address public owner;

	modifier onlyBy(address _address){
		if(msg.sender != _address) throw;
		_;
	}

	function MyToken(address _bank){
		bank = _bank;
		owner = msg.sender;
		totalSupply = 0;
	}

	function transfer(address _to, uint _amount){
		if(balanceOf[_to] + _amount < balanceOf[_to]) throw;
		if(balanceOf[msg.sender] < _amount ) throw;
		balanceOf[msg.sender] -= _amount;
		balanceOf[_to] += _amount;
	}

	function mint(address _to, uint _amount) onlyBy(bank){
		if(balanceOf[_to] + _amount < balanceOf[_to]) throw;
		balanceOf[_to] += _amount;
		totalSupply += _amount;
	}

	function transferByGame(address _from, address _to, uint _amount) onlyBy(owner){
		if(balanceOf[_to] + _amount < balanceOf[_to]) throw;
		if(balanceOf[_from] < _amount ) throw;
		balanceOf[_from] -= _amount;
		balanceOf[_to] += _amount;		
	}

	function changeBank(address _newBank) onlyBy(bank){
		bank = _newBank;
	}
}

contract Game{

	struct Option {
		uint totalGet;
		mapping (address => uint) betInfo;
	}

	Option[2] public options;
	uint public bettingTime;
	uint public totoalReward;
	address public tokenAddress;
	uint winner;
	uint totalSend;
	MyToken money;

	enum State {Create, Betting, GettingResult, Dispatch, End}
	State state;

	event BetScuess(address _address, uint _amount, uint _option);
	event RevealResult(uint _totalA, uint _totalB);
	event Winner(uint _option);
	event Reward(address _receiver, uint _amount);

	modifier onlyAt(State _state){
		if(state != _state) throw;
		_;
	}

	// Stage 0: Create
	// Initialize
	function Game(uint _betTimePeriodInMinutes, address _bank) {
		bettingTime = now + _betTimePeriodInMinutes * 1 minutes;
		state = State.Betting;
		tokenAddress = new MyToken(_bank);
		money = MyToken(tokenAddress);
	}

	// Stage 1: Betting
	function bet(uint _option, uint _amount) onlyAt(State.Betting){
		if(_option >= options.length) throw;
		money.transferByGame(msg.sender, this, _amount);	
		options[_option].betInfo[msg.sender] += _amount;
		options[_option].totalGet += _amount;
		totoalReward += _amount;
		BetScuess(msg.sender, _amount, _option);
		if(now > bettingTime) {
			state = State.GettingResult;
			RevealResult(options[0].totalGet, options[1].totalGet);
		}
	}

	// Stage 2: Getting Result
	function revealResult() onlyAt(State.GettingResult){
		winner = uint(sha3(block.timestamp)) % 2;
		state = State.Dispatch;
		Winner(winner);
	}

	// Stage 3: Dispatch the reward
	function withdraw() onlyAt(State.Dispatch){
		if(winner >= options.length) throw;
		if(options[winner].betInfo[msg.sender] == 0) throw;

		uint value = totoalReward * options[winner].betInfo[msg.sender] / options[winner].totalGet;
		money.transfer(msg.sender, value);
		Reward(msg.sender, value);

		options[winner].betInfo[msg.sender] = 0;
		totalSend += value;

		if(totalSend == totoalReward) state = State.End;
	}

	// helper function 
	function showWinner() constant returns(string _return){
		if(state <= State.GettingResult) _return = "no result";
		else if(winner == 0) _return = "winner is option A,";
		else if(winner == 1) _return = "winner is option B.";
		else throw;
	}

	function showState() constant returns(string _return){
		if(state == State.Create) _return = "Create";
		else if(state == State.Betting) _return = "Betting";
		else if(state == State.GettingResult) _return = "Getting result";
		else if(state == State.Dispatch) _return = "Dispatch";
		else if(state == State.End) _return = "End";
		else throw;
	}
}

