const AmpContract = artifacts.require("Amp");

module.exports = (deployer) => {
    // set the constructor params
    const daiTokenAddress = "0xc7AD46e0b8a400Bb3C915120d284AafbA8fc4735";

    // based on the docs
    // i.e. https://uniswap.org/docs/v2/smart-contracts/router02#address
    const uniswapRouterV2Address = "0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D";

    deployer.deploy(AmpContract, daiTokenAddress, uniswapRouterV2Address)
};