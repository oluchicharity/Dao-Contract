// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract DAO {
    struct Proposal {
        string description;
        uint256 voteCount;
        bool executed;
        uint256 deadline;
    }
    
    address public owner;
    mapping(address => uint256) public votingPower;
    Proposal[] public proposals;

    constructor() {
        owner = msg.sender;
    }

    function createProposal(string memory description) public {
        proposals.push(Proposal({
            description: description,
            voteCount: 0,
            executed: false,
            deadline: block.timestamp + 7 days
        }));
    }

    function vote(uint256 proposalId, uint256 votes) public {
        require(votingPower[msg.sender] >= votes, "Not enough voting power");
        require(block.timestamp <= proposals[proposalId].deadline, "Voting period over");

        proposals[proposalId].voteCount += votes;
        votingPower[msg.sender] -= votes;
    }

    function executeProposal(uint256 proposalId) public {
        Proposal storage proposal = proposals[proposalId];
        require(block.timestamp > proposal.deadline, "Voting period is not over yet");
        require(!proposal.executed, "Proposal already executed");

        proposal.executed = true;
    }

    function allocateVotingPower(address voter, uint256 amount) public {
        require(msg.sender == owner, "Only owner can give voting power");
        votingPower[voter] += amount;
    }
}
