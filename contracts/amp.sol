/*
AMP
Copyright 2017-2020 AMP Development

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.


This code does not constitute an offer or a means to sell or a solicitation of an offer to buy a security
in any jurisdiction in which it is unlawful to make such an offer or solicitation.  This technology is not built to enable securitization, but accounting transparency in asset-backed and non-asset-backed transactions.
All notices regarding the AMP market include notices of restrictions for the participation by US-citizens and residents of the US, South Korea, United Kingdom and the EU.

*/

pragma experimental ABIEncoderV2;
pragma solidity 0.6.6;


interface OrFeedInterface {
  function getExchangeRate ( string calldata fromSymbol, string calldata  toSymbol, string calldata venue, uint256 amount ) external view returns ( uint256 );
  function getTokenDecimalCount ( address tokenAddress ) external view returns ( uint256 );
  function getTokenAddress ( string calldata  symbol ) external view returns ( address );
  function getSynthBytes32 ( string calldata  symbol ) external view returns ( bytes32 );
  function getForexAddress ( string calldata symbol ) external view returns ( address );
  function arb(address  fundsReturnToAddress,  address liquidityProviderContractAddress, string[] calldata   tokens,  uint256 amount, string[] calldata  exchanges) external payable returns (bool);
}


contract AMP{

    using SafeMath for uint256;
  
    // orfeed interface
    OrFeedInterface orfeed;
    
    // the owner of the contract
    address owner;
    
    // Represents a single asset
    struct Asset {
    
        address tokenAddress;
        string title;
        string description;
        string entityName;
        uint256 proposedMarketCapUSD;
        string fileHash1;
        string fileHash2;
        string photo1URL;
        string photo2URL;
        string photo3URL;
        bool assetActive;
        string inActiveStatusReason;
    }
    
    
    // a mapping of assets in the contract
    mapping (bytes32 => Asset) assets;
    

    constructor() public {
        owner = msg.sender;
    }
    
    
    modifier onlyOwner() {
        if (msg.sender != owner) {
            revert();
        }
        _;
    }
    
    function setOrfeedAddress(address orfeedAddress) onlyOwner external {
        orfeed = OrFeedInterface(orfeedAddress);
    }
    
    

    function getCreditScore(address entityAddress) public view returns (uint256 score){

    }

    function getPrice(address tokenAddress, uint256 amount, uint256 side, string memory venue) public view returns (uint256 price){
        bytes32 assetId =  keccak256(abi.encodePacked(tokenAddress));

    }

    function getSwapPrice(address fromTokenAddress, address toTokenAddress, uint256 amount, uint256 side, string memory venue) public view returns (uint256 price){

    }


    function getProposedYield(address tokenAddress) public view returns (uint256 percentage){
      bytes32 assetId =  keccak256(abi.encodePacked(tokenAddress));

    }

    function getHistoricYield(address tokenAddress, uint256 years) public view returns (uint256 percentage){
        bytes32 assetId =  keccak256(abi.encodePacked(tokenAddress));

    }

    function getProposedMarketCap(address tokenAddress) public view returns (uint256 marketCap){
        bytes32 assetId =  keccak256(abi.encodePacked(tokenAddress));
        return assets[assetId].proposedMarketCapUSD;

    }

    function getAssetPredictionScoreAndSize(address tokenAddress)  public view returns (uint256 score, uint256 totalPredictionMarketSize){
        bytes32 assetId =  keccak256(abi.encodePacked(tokenAddress));

    }

    function getPredictionMarketAssetExpirationDate() public view returns (uint256 timestamp){

    }

    function getPredictionBalance(address predictorAddress, address tokenAddress) public view returns (uint256 currentBalance, uint256 side){
        bytes32 assetId =  keccak256(abi.encodePacked(tokenAddress));


    }


    function isAssetOnAMP(address tokenAddress)  public view returns (bool isOn){
        bytes32 assetId =  keccak256(abi.encodePacked(tokenAddress));

    }

    function isPredictionMarketResolved(address tokenAddress)  public view returns (bool isOn){
        bytes32 assetId =  keccak256(abi.encodePacked(tokenAddress));

    }


    function rateEntityForCreditScore(address entityAddress, uint256 proposedScore) public returns(bool){

    }

    function swapAsset(address toAsset, address fromAsset, uint256 amountInput, int256 minimumOutput) public returns(uint256 outputAmount){

    }

    function predictForOrAgainst(address tokenAddress, bool predictFor, uint256 amountStableCoinStaked) public returns(bool){
        bytes32 assetId =  keccak256(abi.encodePacked(tokenAddress));

    }

    function resolvePredictionMarketAsset(address tokenAddress)  public returns(bool resolved){
        bytes32 assetId =  keccak256(abi.encodePacked(tokenAddress));

    }
    

    function addAssetToMarket(address tokenAddress, string memory title, string memory description, string memory entityName, uint256 proposedMarketCapUSD, string memory fileHash1, string memory fileHash2, string memory photo1URL, string memory photo2URL, string memory photo3URL ) public {
        bytes32 assetId =  keccak256(abi.encodePacked(tokenAddress));
        assets[assetId] = Asset(tokenAddress, title, description, entityName, proposedMarketCapUSD, fileHash1, fileHash2, photo1URL, photo2URL, photo3URL, true, "");
    }


    function inactivateAsset(address tokenAddress, string memory reasonGivenByAdminOrCreator ) public {
       bytes32 assetId =  keccak256(abi.encodePacked(tokenAddress));
       assets[assetId].assetActive = false;
       assets[assetId].inActiveStatusReason = reasonGivenByAdminOrCreator;
    }

    function claimPredictionRewards(address tokenAddress) public returns(uint256 amountReturned){
       bytes32 assetId =  keccak256(abi.encodePacked(tokenAddress));

    }

    function claimAssetRewards(address tokenAddress) public returns(uint256 amountReturned){
       bytes32 assetId =  keccak256(abi.encodePacked(tokenAddress));

    }

    function claimAssetSaleRewards(address tokenAddress) public returns(uint256 amountReturned){
       bytes32 assetId =  keccak256(abi.encodePacked(tokenAddress));

    }

    function contributeAssetRegularRewards(address tokenAddress, uint256 amountUSD) public returns(bool){
       bytes32 assetId =  keccak256(abi.encodePacked(tokenAddress));

    }
    function contributeAssetSaleRewards(address tokenAddress, uint256 amountUSD) public returns(bool){
       bytes32 assetId =  keccak256(abi.encodePacked(tokenAddress));

    }

}



library SafeMath {
    function mul(uint256 a, uint256 b) internal view returns(uint256) {
        uint256 c = a * b;
        assert(a == 0 || c / a == b);
        return c;
    }

    function div(uint256 a, uint256 b) internal view returns(uint256) {
        assert(b > 0); // Solidity automatically throws when dividing by 0
        uint256 c = a / b;
        assert(a == b * c + a % b); // There is no case in which this doesn't hold
        return c;
    }

    function sub(uint256 a, uint256 b) internal view returns(uint256) {
        assert(b <= a);
        return a - b;
    }

    function add(uint256 a, uint256 b) internal view returns(uint256) {
        uint256 c = a + b;
        assert(c >= a);
        return c;
    }
}
    