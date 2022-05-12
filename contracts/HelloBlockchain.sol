// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract HelloBlockchain {
  enum StateType {Request, Respond}

    //List of properties
    StateType public State;
    address public Requestor;
    address public Responder;

    string public RequestMessage;
    string public ResponseMessage;

    event StateChanged(string stateData);

    // constructor function
    constructor(string memory message) public {
        RequestMessage = message;
        State = StateType.Request;

        emit StateChanged("Request");
    }

    // call this function to send a request
    function SendRequest(string memory requestMessage) public {
        Requestor = msg.sender;

        RequestMessage = requestMessage;
        RequestMessage = string(abi.encodePacked(RequestMessage," Versioned"));
        State = StateType.Request;
    }

    // call this function to send a response
    function SendResponse(string memory responseMessage) public {
        Responder = msg.sender;

        // call ContractUpdated() to record this action
        ResponseMessage = responseMessage;
        State = StateType.Respond;

        emit StateChanged("Response");
    }

    function getMessage() public view returns (string memory) {
        if (State == StateType.Request) return RequestMessage;
        else return ResponseMessage;
    }
}