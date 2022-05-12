# BlockChainKickStarter
This blog contains 5 step process to learn the basics of Blockchain to build and deploy an blockchain application

BlockChain KickStarter From Scratch
This blog contains 5 step process to learn the basics of Blockchain to build and deploy an blockchain application
Prerequisites
Create Smart Contract
Build & Deploy Smart Contract
Execute Smart Contract
Check Ethereum usage in Galanche

Prerequisites
Install the 14.x version of Node, you can download the same from Here
Install the latest version of Git(if not installed), you can download the same from Here
Install the latest version of Visual studio code, you can download the same from Here
Create a folder in any of your drives and name it as BlockChainKickStarter.
Navigate to the BlockChainKickStarter. Right-click and select Git Bash Here
Update npm by executing the following command in git prompt - npm update -g npm. If you have already have npm, make sure you have version 8.0 and above. You can check by running npm -v in the git prompt.
Install Truffle, by executing the following comment in git prompt - npm install -g truffle
Install Ganache, by executing the following comment in git prompt - npm install -g ganache-cli
Open Visual Studio Code and search for 'Blockchain Development Kit for Ethereum' and install the extension
Open Visual Studio Code and search for 'Truffle for VS Code' and install the extension
Download the latest version of the Ganache GUI Version, you can download the same from Here. After installation, click on continue on the Ganache window and then click on 'Quick Start Ethereum'

Create Smart Contract
In Visual studio code, navigate to BlockChainKickStarter Folder
Open the terminal by pressing CTRL + ~ .
Run the following command truffle init to initialize the truffle project to create solidity program files for development.
Create a new file called 'HelloBlockchain.sol' in the contracts folder and copy paste the code below in 'HelloBlockchain.sol'

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
Create a new file called '2_deploy_contracts.js' in the migrations folder copy paste the code below in '2_deploy_contracts.js'

var HelloBlockchain = artifacts.require("HelloBlockchain");
var Arg = "Hello world";
module.exports = deployer => {
    deployer.deploy(HelloBlockchain, Arg);
};
Navigate to truffle-config.js and copy the below code and replace it by deleting all other contents.

module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "5777",
    }
  }
}
Build & Deploy Smart Contract
Right Click on 'HelloBlockchain.sol' file and select 'Build Contracts'
To see the build logs, Click on the Output tab and select the 'Truffle for VS Code' as shown in the following screenshot

Right Click on 'HelloBlockchain.sol' file and select 'Deploy Contracts', you will be prompted with the network, select development.

If all works well, you should see the following message 'Deploy Succeeded'.

Execute Smart Contract
In order to test the smart contract you need to add js files to the project.
Create a file with the name 'sendmessage.js' in BlockChainKickStarter folder copy the code below and paste it in 'sendmessage.js'

var HelloBlockchain = artifacts.require("HelloBlockchain");

module.exports = function(done) {
  console.log("Getting the deployed version of the HelloBlockchain smart contract")
  HelloBlockchain.deployed().then(function(instance) {
    console.log("Calling SendRequest function for contract ", instance.address);
    return instance.SendRequest("Hello, blockchain!");
  }).then(function(result) {
    console.log("Transaction hash: ", result.tx);
    console.log("Request complete");
    done();
  }).catch(function(e) {
    console.log(e);
    done();
  });
};
Now send the data using the following command. truffle exec sendmessage.js --network development
You should see the following message

Create a file with the name 'getmessage.js' in BlockChainKickStarter folder copy the code below and paste it in 'getmessage.js'

Now send the data using the following command. truffle exec getmessage.js --network development
You should see the following message

Check Etherum usage in Galanche
Open Ganache by typing Ganache in Windows Search for Windows and Open finder and move to application and find Ganache in Application.
You should see the Gas being used and number of Transaction that has happened while running your JS file.

You can see the transaction that used the gas and the equivalent amount of gas used.