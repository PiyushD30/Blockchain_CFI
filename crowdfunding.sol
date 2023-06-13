pragma solidity 0.8.20;

contract crowdFunding {
    address payable public admin;
    uint public goalAmount = 100 ether;
    uint public totalAmount = 0;
    mapping(address => uint) public person_paid;
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
  
    modifier goalNotReached(){
        require(totalAmount < goalAmount,"Goal Reached");
        _;
    }
    
    modifier campaignIsOpen(){
        require(time < 2 days,"Campaign Closed!");
        _;
    }
    
    function contribute(uint amount) public payable goalNotReached campaignIsOpen {
        amount=msg.value;
        uint t=0;
        uint i=0;
        time = block.timestamp-start_time;
        require(amount <= goalAmount,"Too High Amount!");
        for(i=0; i<people_no;i++){
            if(person[i]==msg.sender){
                t=1;
                break;
            }
        }
        if(t==0){
        person.push(msg.sender);
        person_paid[person[people_no]] +=amount;
        totalAmount += amount;
        people_no++;
        } 
        else{
        person_paid[person[i]] += amount;
        totalAmount += amount;
        }  
    }
    
    function refund() public payable goalNotReached {
        require(time > 2 days,"Campaign is Ongoing.");
        for(uint i=0; i<people_no;i++){
            payable(person[i]).transfer(person_paid[person[i]]);
            person_paid[person[i]]=0;
        }
        totalAmount=0;
    }
    
    function transfer_fund(uint transfer_amount) public payable onlyAdmin {
        if (goalAmount >= totalAmount && transfer_amount<= totalAmount) {
            totalAmount -= transfer_amount;
            payable(admin).transfer(transfer_amount);
        }
    }
}
//SPDX-License-Identifier: UNLICENSED
