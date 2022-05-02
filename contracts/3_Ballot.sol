// SPDX-License-Identifier: GPL-3.0

// pragma solidity >=0.7.0 <0.9.0;
pragma solidity ^0.4.17;

contract Campaign {

    struct Request {
        string description;
        uint value;
        address recipient;
        bool complete;
    }

    Request[] public requests;
    address public manager;
    uint public minimumContribution;
    address[] public approvers;


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
        approvers.push(msg.sender);
    }

    function createRequest(string description, uint value, address recipient) public restricted {
        Request memory newRequest = Request({
            description: description,
            value: value,
            recipient: recipient,
            complete: false
        });

        requests.push(newRequest);
    }

    // wrong approve reques approach

    function approveRequest(Request request) public {
        bool isApprover = false;
        // making sure person calling this function has donated
        for(uint i=0;i < approvers.length; i++) {
            if(approvers[i] == msg.sender) {
                isApprover = true;
            }
        }
        require(isApprover);
        
        // making sure porson calling tthsi function haset voted yet
        for(uint =0; i<request.approvers.length;i++) {
            require(request.approvers[i] != msg.sender);
        }

        // these for loops are very costly as the number of contributors increases.
    }




}