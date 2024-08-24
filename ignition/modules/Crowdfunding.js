const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

module.exports = buildModule("CrowdfundingModule", function (m) {
  const crowdfunding = m.contract("Crowdfunding");

  return { crowdfunding };
});