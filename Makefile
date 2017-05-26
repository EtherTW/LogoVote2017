test: test-LogoVote
test-LogoVote:
	cd LogoVote/truffle && testrpc &
	cd LogoVote/truffle && truffle test