const Purse = artifacts.require("Purse");

module.exports = function (deployer) {
  deployer.deploy(Purse);
};
