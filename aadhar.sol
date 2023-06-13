pragma solidity 0.8.20;

contract aadhar{
    struct Person {
        string name;
        string dob;
        string Address;
        uint aadhar_no;
        address walletAddress;
    }

    mapping(uint => Person) private person;
    
    function storeDetails(string memory name,string memory dob,string memory aadharAddress,uint aadhar_no) public {
        person[aadhar_no] = Person(name, dob, aadharAddress,aadhar_no, msg.sender);
    }

    function getAadhar(uint _aadhar_no) public view  returns (string memory, string memory, string memory,uint, address) {
        Person memory _person = person[_aadhar_no];
        return (_person.name, _person.dob, _person.Address,_person.aadhar_no, _person.walletAddress);
    }
}
//SPDX-License-Identifier: UNLICENSED

