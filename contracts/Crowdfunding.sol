// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.24;

contract Crowdfunding {

    address public owner; // the person in charge of the contract/deployer

    struct Campaign { 
        string tittle; //The name of the campaign.
        string description; //A brief description of the campaign.
        string benefactor; //The address of the person or organization that will receive the funds.
        uint256 goal; //The fundraising goal (in wei).
        uint256 deadline; // The Unix timestamp when the campaign ends.
        uint256 amountRaised; //The total amount of funds raised so far.
    }

    mapping (string => Campaign) public campaigns; //unique idenfyer to store campaign with

     modifier onlyOwner() {
        require(msg.sender == owner, "You are not the contract owner");
        _;
    }

    event CampaignCreated(string _campaignId,uint256 _goal,string _benefactor,uint256 _deadline); 
    event DonationReceived();
    event CampaignEnded();

     constructor() {
        owner = msg.sender;
    }

    //function to create a campaign
    function createCampaign(string memory _campaignId,string memory _title, string memory _description, string memory _benefactor, uint256 _goal, uint256 _deadline) public onlyOwner {
        require(_goal>0,"goal amount cannot be zero"); //check that the amount in the goal is not zero 
        require(_deadline > block.timestamp,"deadline cannot be the future"); //check that deadline not less that the current time 
        campaigns[_campaignId] = Campaign({
            tittle: _title,
            description: _description,
            benefactor: _benefactor,
            goal: _goal,
            deadline: _deadline,
            amountRaised: 0
        });

        emit CampaignCreated(_campaignId,_goal,_benefactor,_deadline);
    }
    //function to donate to a campaign 
    function donateToCampaign(string memory campaignId, uint256 _donationAmount) public {
        
    }
    function endCampaign() public {
        
    }
}