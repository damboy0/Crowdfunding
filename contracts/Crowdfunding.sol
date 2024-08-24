// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.24;

contract Crowdfunding {

    address public owner; // the person in charge of the contract/deployer

    struct Campaign { 
        string tittle; //The name of the campaign.
        string description; //A brief description of the campaign.
        address payable benefactor; //The address of the person or organization that will receive the funds.
        uint256 goal; //The fundraising goal (in wei).
        uint256 deadline; // The Unix timestamp when the campaign ends.
        uint256 amountRaised; //The total amount of funds raised so far.
    }

    mapping (string => Campaign) public campaigns; //unique idenfyer to store campaign with

    //This allows only the owner to call a fuction that it is added to 
     modifier onlyOwner() {
        require(msg.sender == owner, "You are not the contract owner");
        _;
    }

    event CampaignCreated(string campaignId,uint256 goal,address benefactor,uint256 deadline); 
    event DonationReceived(string campaignId,uint256 donatedAmount);
    event CampaignEnded();

     constructor() {
        owner = msg.sender;
    }

    //function to create a campaign. has onlyowner to allow only the owner of the contract to call it 
    function createCampaign(string memory _campaignId,string memory _title, string memory _description, address payable _benefactor, uint256 _goal, uint256 _deadline) public onlyOwner {
        require(_goal>0,"goal amount cannot be zero"); //check that the amount in the goal is not zero 
        require(_deadline > block.timestamp,"Deadline must be in the future"); //check that deadline not less that the current time and in the future
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
    //function to donate to a campaign. has "payable" keyword because it is to receive fund(ether)
    function donateToCampaign(string memory _campaignId) public payable{
        require(msg.value > 0,"Amout to donate must be more than zero"); //msg.value is the value of the ether donates 

        Campaign storage campaign = campaigns[_campaignId]; // to retrieve the campaign mapping from the struct
        campaign.amountRaised += msg.value;

        emit DonationReceived(_campaignId,msg.value);
        
    }

    //function to endcampaign
    function endCampaign(string memory _campaignId,uint256 _deadline) public onlyOwner {
        require( _deadline != block.timestamp);

        Campaign storage campaign = campaigns[_campaignId]; // to retrieve the campaign mapping from the struct
    }
}