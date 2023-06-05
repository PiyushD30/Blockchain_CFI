pragma solidity 0.8.20;

contract crowdFunding {
    address payable public admin;
    uint public goalAmount = 100 ether;
    uint public totalAmount = 0;
    mapping(address => uint) public pay;
    address[] person;
    uint public people_no = 0;
    uint start_time;
    uint public time;

    constructor(uint _goalAmount, uint _start_time) {
        admin = payable(msg.sender);
        goalAmount = _goalAmount;
        start_time = _start_time;
        time = block.timestamp -_start_time;
    }
    
    modifier onlyAdmin() {
        require(msg.sender == admin, "Only the admin can access!");
        _;
    }
    
    function contribute() public payable {
        time = block.timestamp-start_time;
        require(totalAmount < goalAmount, "Goal Reached!");
        require(time < 2 days , "Campaign Closed!");
        person.push(msg.sender);
        pay[person[people_no]] = msg.value;
        totalAmount += msg.value;
        people_no++;
    }
    
    function refund() public {
        require(totalAmount < goalAmount);
        require(time > 2 days);
        for(uint i=0; i<people_no;i++){
            payable(person[i]).transfer(pay[person[i]]);
        }
    }
    
    function closeCampaign() public onlyAdmin {
        if (goalAmount == totalAmount) {
            admin.transfer(totalAmount);
            totalAmount = 0;
        }
    }
}
