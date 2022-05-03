// SPDX-License-Identifier: GPL-3.0

// pragma solidity >=0.7.0 <0.9.0;
pragma solidity ^0.4.17;

contract Campaign {

    struct Request {
        string description;
        uint value;
        address recipient;
        bool complete;
        uint approvalCount;
        mapping(address => bool) approvals;
    }

    Request[] public requests;
    address public manager;
    uint public minimumContribution;
    // address[] public approvers;
    mapping(address => bool) public approvers;


    modifier restricted() {
        require(msg.sender == manager);
        _;
    }

    function Campaign(uint minimum) public {
        manager = msg.sender;
        minimumContribution = minimum;
    }

    function contribute() public payable {
        require(msg.value >= minimumContribution);
        // approvers.push(msg.sender);
        approvers[msg.sender] = true; // add new key to the approvers mapping in mapping only value is stored and not the key
    }

    function createRequest(string description, uint value, address recipient) public restricted {
        Request memory newRequest = Request({
            description: description,
            value: value,
            recipient: recipient,
            complete: false,
            approvalCount: 0
        });

        requests.push(newRequest);
    }

    // wrong approve reques approach

    // function approveRequest(Request request) public {
    //     bool isApprover = false;
    //     // making sure person calling this function has donated
    //     for(uint i=0;i < approvers.length; i++) {
    //         if(approvers[i] == msg.sender) {
    //             isApprover = true;
    //         }
    //     }
    //     require(isApprover);
        
    //     // making sure porson calling tthsi function haset voted yet
    //     for(uint i=0; i<request.approvers.length;i++) {
    //         require(request.approvers[i] != msg.sender);
    //     }

    //     // these for loops are very costly as the number of contributors increases.
    // }

    // mappings are non iterable only good for retrieveing single value in o(1).
    // mappings works like has table but dosent give eerror or null when the key is not present. we get default value.
    // default value depend on the other values are string or numbers ('', 0)

    function approveRequest(uint index) public {
        Request storage request = requests[index];

        require(approvers[msg.sender]);
        require(!request.approvals[msg.sender]);
        
        request.approvals[msg.sender] = true;
        request.approvalCount++;
    }




}