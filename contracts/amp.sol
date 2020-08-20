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

// SafeMath
import "@openzeppelin/contracts/math/SafeMath.sol";

// ERC20
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// Uniswap
import '@uniswap/v2-periphery/contracts/UniswapV2Router02.sol';


interface OrFeedInterface {
  function getExchangeRate ( string calldata fromSymbol, string calldata  toSymbol, string calldata venue, uint256 amount ) external view returns ( uint256 );
  function getTokenDecimalCount ( address tokenAddress ) external view returns ( uint256 );
  function getTokenAddress ( string calldata  symbol ) external view returns ( address );
  function getSynthBytes32 ( string calldata  symbol ) external view returns ( bytes32 );
  function getForexAddress ( string calldata symbol ) external view returns ( address );
  function requestAsyncEvent(string calldata eventName, string calldata source)  external view returns(string memory); 
  function arb(address  fundsReturnToAddress,  address liquidityProviderContractAddress, string[] calldata   tokens,  uint256 amount, string[] calldata  exchanges) external payable returns (bool);
}


contract AMP {
    

    using SafeMath for uint256;
  
    // orfeed interface
    OrFeedInterface orfeed;
    
    // dai tokenAddress
    ERC20 daiToken;
    
    // the uniswap v2 router
    UniswapV2Router02 uniswap;
    
    // the owner of the contract
    address owner;

    // the address of the uniswap v2 router to use
    address uniswapAddress;
    
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
    }
    
    
    // Represents a single prediction
    struct Prediction {
        address userAddress;
        bool predictFor;
        uint256 amountStableCoinStaked;
    }
    
    
     // Represents a token issuer i.e. the person who adds the asset to the assurance market
    struct TokenIssuer {
        address issuerAddress;
        uint256 dateIssued; // date the token was added to the market
    }
    
    // a mapping of assets in the contract
    mapping (address => Asset) assets;
    
     // a mapping of assets in the contract
    mapping (address => TokenIssuer) tokenIssuers;
    
    // a mapping of predictions for each asset
    mapping (address => Prediction[]) predictions;
    
    // a mapping of each tokens resolution date
    mapping (address => uint256) assetResolutionDate;
    

    constructor(address _daiTokenAddress, address _uniswapAddress) public {
        
        // set the owner of the contract
        owner = msg.sender;
        
        // init the dai token address
        daiToken = ERC20(_daiTokenAddress);
        
        //init the uniswap router
        uniswapAddress = _uniswapAddress;
        uniswap = UniswapV2Router02(_uniswapAddress);        
    }
    
    // check that the user is the owner of the contract
    modifier onlyOwner() {
        if (msg.sender != owner) {
            revert();
        }
        _;
    }
    
    // contract events
    event AssetAdded(address _tokenAddress, uint256 _resolutionDate);
    event AssetInactivated(address _tokenAddress, string _reasonGivenByAdminOrCreator);
     
    
    /// @notice allow the owner to set the address of the orfeed contract
    /// @param _orfeedAddress the new address of the orfeed contract
    /// @return true
    function setOrfeedAddress(address _orfeedAddress) onlyOwner external returns(bool) {
        orfeed = OrFeedInterface(_orfeedAddress);
        return true;
    }

    function getCreditScore(address entityAddress) public view returns (uint256 score){
        // placeholder for now
        (score) = 200;
    }
    
    // I changed the return type to string because of the complexity of string to unit256 parsing in solidity, was getting alot of underflows here
    function getPrice(address tokenAddress, uint256 amount, string memory venue) public view returns (string memory price){
        string memory tokenSymbol = ERC20(tokenAddress).symbol();
        string memory priceQuery = string(abi.encodePacked("https://min-api.cryptocompare.com/data/price?fsym=", tokenSymbol, "&tsyms=USD"));
        (price) = orfeed.requestAsyncEvent(priceQuery, "CHAINLINK");
    }

    function getSwapPrice(address fromTokenAddress, address toTokenAddress, uint256 amount, string memory venue) public view returns (uint256 price) {
        string memory fromTokenSymbol = ERC20(fromTokenAddress).symbol();
        string memory toTokenSymbol = ERC20(toTokenAddress).symbol();
        (price) = orfeed.getExchangeRate(fromTokenSymbol, toTokenSymbol, venue, amount);
    }

    function getProposedYield(address tokenAddress) public view returns (uint256 percentage){
        // placeholder for now
        (percentage) = 200;
    }

    function getHistoricYield(address tokenAddress, uint256 numOfYears) public view returns (uint256 percentage){
        // placeholder for now
        (percentage) = 200;
    }

    function getProposedMarketCap(address tokenAddress) external view returns (uint256 marketCap){
        // placeholder for now
        (marketCap) = assets[tokenAddress].proposedMarketCapUSD;
    }

    function getAssetPredictionScoreAndSize(address tokenAddress)  external view returns (uint256 score, uint256 totalPredictionMarketSize){
        // placeholder for now
        (score, totalPredictionMarketSize) = (200, 200);
    }

    function getPredictionMarketAssetExpirationDate(address tokenAddress) external view returns (uint256 timestamp) {
          // placeholder for now
        (timestamp) = assetResolutionDate[tokenAddress];
    }

    function getPredictionBalance(address predictorAddress, address tokenAddress) public view returns (uint256 currentBalance, uint256 side){
         // placeholder for now
        (currentBalance, side) = (200, 200);
    }


    function isAssetOnAMP(address tokenAddress)  public view returns (bool isOn){
        // placeholder for now
        (isOn) = true;
    }

    function isPredictionMarketResolved(address tokenAddress)  public view returns (bool isOn){
         // placeholder for now
        (isOn) = true;

    }


    function rateEntityForCreditScore(address entityAddress, uint256 proposedScore) public returns(bool){
         // placeholder for now
        return true;
    }

    function swapAsset( address fromAsset, address toAsset, uint256 amountInput, uint256 minimumOutput) external returns(uint256 outputAmount){
        
        require(ERC20(fromAsset).transferFrom(msg.sender, address(this), amountInput), 'transferFrom failed.');
        require(ERC20(fromAsset).approve(address(uniswapAddress), amountInput), 'approve failed.');
        
        // get the asset swap price via orfeed
        uint256 swapPrice = getSwapPrice(fromAsset, toAsset, amountInput, "UNISWAPBYSYMBOLV2");
        
        address[] memory path = new address[](2);
        path[0] = fromAsset;
        path[1] = toAsset;
        
        // do the swap via uniswap v2
        uniswap.swapExactTokensForTokens(amountInput, minimumOutput, path, msg.sender, block.timestamp);
        (outputAmount) = swapPrice;
    }

    function predictForOrAgainst(address tokenAddress, bool predictFor, uint256 amountStableCoinStaked) payable external returns(bool) {
        
        require(msg.value > 0, "Please send some ETH that'll be used for the prediction");

        uint256 swapPrice = orfeed.getExchangeRate("ETH", "DAI", "UNISWAPBYSYMBOLV2", amountStableCoinStaked);
        predictions[tokenAddress].push(Prediction(msg.sender, predictFor, amountStableCoinStaked));
        
        return true;
    }

    function resolvePredictionMarketAsset(address tokenAddress)  public returns(bool resolved) {
       // placeholder for now
        (resolved) = true;
    }
    

    function addAssetToMarket(address tokenAddress, string memory title, string memory description, string memory entityName, uint256 proposedMarketCapUSD, string memory fileHash1, string memory fileHash2, string memory photo1URL, string memory photo2URL, string memory photo3URL ) public {
        // add the asset
        assets[tokenAddress] = Asset(tokenAddress, title, description, entityName, proposedMarketCapUSD, fileHash1, fileHash2, photo1URL, photo2URL, photo3URL);
        
        // set the token issuer
        tokenIssuers[tokenAddress] = TokenIssuer(msg.sender, now);
        
        // calculate and set  its resolution date
        uint256 resolutionDate = now + 365 days;
        assetResolutionDate[tokenAddress] = resolutionDate;
        
        // then emit the appropriate event
        emit AssetAdded(tokenAddress, resolutionDate);
    }

    function inactivateAsset(address tokenAddress, string memory reasonGivenByAdminOrCreator ) public {
       // remove the asset from the assets mapping
       delete assets[tokenAddress];
       
       // remove the issuer of the token
       delete tokenIssuers[tokenAddress];
       
       // delete its resolution date
       delete assetResolutionDate[tokenAddress];
       
       // then emit an event explaining why the asset was inactivated
       emit AssetInactivated(tokenAddress, reasonGivenByAdminOrCreator);
    }

    function claimPredictionRewards(address tokenAddress) public returns(uint256 amountReturned) {
        
        // placeholder for now
        (amountReturned) = 200;
    }

    function claimAssetRewards(address tokenAddress) public returns(uint256 amountReturned) {
         // placeholder for now
        (amountReturned) = 200;
    }

    function claimAssetSaleRewards(address tokenAddress) public returns(uint256 amountReturned){
         // placeholder for now
        (amountReturned) = 200;
    }

    function contributeAssetRegularRewards(address tokenAddress, uint256 amountUSD) public returns(bool){
         // placeholder for now
        return true;
    }
    
    function contributeAssetSaleRewards(address tokenAddress, uint256 amountUSD) public returns(bool){
         // placeholder for now
        return true;
    }

}