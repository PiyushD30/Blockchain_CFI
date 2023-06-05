pragma solidity 0.8.20;

contract aadhar{
    struct Person {
        string name;
        string dob;
        string Address;
        address walletAddress;
    }

    mapping(address => Person) private person;
    
    function storeDetails(string memory name,string memory dob,string memory aadharAddress) public {
        person[msg.sender] = Person(name, dob, aadharAddress, msg.sender);
    }

    function getAadhar() public view  returns (string memory, string memory, string memory, address) {
        Person memory _person = person[msg.sender];
        return (_person.name, _person.dob, _person.Address, _person.walletAddress);
    }
}
