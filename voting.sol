pragma solidity 0.8.20;
contract voting {
    struct Candidate {
        uint candidate_no;
        string name;
        uint votes;
    }

    Candidate[] public candidate;
    uint public candidate_count=0;
    mapping(address => bool) public voter;

    function addCandidate(string memory name) private {
        candidate_count++;
        candidate.push(Candidate(candidate_count, name,0));
    }

    function vote(uint _candidate_no) public {
        require(!voter[msg.sender], "You have already voted");
        candidate[_candidate_no].votes++;
        voter[msg.sender] = true;
    }

    function Winner() public view returns (uint, string memory, uint votes) {
        uint winnerVote = 0;
        uint winner_id = 0;

        for (uint i = 1; i <= candidate_count; i++) {
            if (candidate[i].votes > winnerVote) {
                winnerVote = candidate[i].votes;
                winner_id = candidate[i].candidate_no;
            }
        }
        Candidate memory winner = candidate[winner_id];
        return (winner.candidate_no, winner.name, winner.votes);
    }
}
