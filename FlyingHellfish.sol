
// SPDX-License_Identifier: MIT
pragma solidity ^0.6.0;
import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";


contract FlyingHellfish  {
// this contract will implement a tontine with five members
// to join the user needs to send minimum .0007 ETH to the contract address
// the member wallet will identify the user
// members will need to send ETH once every 2 years to check in, ETH will not be accepted

uint public _MemberLimit = 5; // array index so 5 members
uint public _Members; // current count of members
//uint public _DeathInterval = 63158400;  // 2 years and a day in seconds
uint public _DeathInterval = 1; 
uint256 testvar1; function getTestVar1 () public returns (uint256) { return testvar1; }

mapping (address =>uint256) public theHellFish; // holds timestamp of last adddress interaction
address [] public hellFishAddresses; // array with the current addresses for looping the map

// look through hellfish timestamps and
function checkForDeadHellfish(address thisHellfish) public {
    uint256 rightNow = block.timestamp;
    uint alivecount = 1; //counts current user
    for(uint i=0; i < _MemberLimit; i++) {
        uint256 hellfishLastCheckin = theHellFish[hellFishAddresses[i]];
        if(hellFishAddresses[i] != thisHellfish) {  
            // check the other guy's last checkin
            if(hellfishLastCheckin > (rightNow - _DeathInterval)) {
            //if(hellfishLastCheckin > (rightNow - 2)) {
                 alivecount++;
            }
        }
        //
    }
    if(_Members == _MemberLimit && alivecount == 1) {
        // you're a tough sonofobich
        // payout
        selfdestruct(payable(thisHellfish));
    }
}


function Hellfish() public payable {
    
    if(theHellFish[msg.sender] > 0) {
        // this is a check-in
        if(msg.value == 0) {
        checkForDeadHellfish(msg.sender);
        } else {
        revert("call with no ETH");
        }
    } 
    else if(_MemberLimit == _Members) { 
        revert("no room in the crew, bro");
    }
    else
    {
        // You're a gutsy daredevil with a give-em-hell attitude and a 4th grade education.
        require(msg.value >= .0007 ether);
        theHellFish[msg.sender] = block.timestamp;
        hellFishAddresses.push(msg.sender);
        _Members++;
    }

    
}


function _FullTontineTest () public payable {
        address test1 = 0x617F2E2fD72FD9D5503197092aC168c91465E7f2;
        address test2 = 0x17F6AD8Ef982297579C203069C1DbfFE4348c372;
        address test3 = 0x5c6B0f7Bf3E7ce046039Bd8FABdfD3f9F5021678;
        address test4 = 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c;
        address test5 = 0x0A098Eda01Ce92ff4A4CCb7A4fFFb5A43EBC70DC;
        theHellFish[test1] = block.timestamp;
        theHellFish[test2] = block.timestamp;
        theHellFish[test3] = block.timestamp;
        theHellFish[test4] = block.timestamp;
        theHellFish[test5] = block.timestamp;
        hellFishAddresses.push(test1);
        hellFishAddresses.push(test2);
        hellFishAddresses.push(test3);
        hellFishAddresses.push(test4);
        hellFishAddresses.push(test5);
        _Members = 4;
    }

function _FullTontineWinnerTest () public {
// run after _FullTontineTest



}
   
    
}
