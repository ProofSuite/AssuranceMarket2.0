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


contract Amp {
    

    using SafeMath for uint256;
  
    // orfeed interface
    OrFeedInterface orfeed;
    
    // dai tokenAddress
    IERC20 daiToken;
    
    // the uniswap v2 router
    UniswapV2Router02 uniswap;
    
    // the owner of the contract
    address owner;

    // the address of the uniswap v2 router to use
    address payable uniswapAddress;
    
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
        uint256 assetSaleRewards;
        uint256 assetRegularRewards;
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
    mapping (address => uint256) assetResolutionDates;
    

    constructor(address _daiTokenAddress, address payable _uniswapAddress) public {
        
        // set the owner of the contract
        owner = msg.sender;
        
        // init the dai token address
        daiToken = IERC20(_daiTokenAddress);
        
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
    
    function getPrice(string memory fromTokenSymbol, uint256 amount, string memory venue) public view returns (uint256 price){
       (price) = orfeed.getExchangeRate(fromTokenSymbol, "USD", venue, amount);
    }

    function getSwapPrice(string memory fromTokenSymbol, string memory toTokenSymbol, uint256 amount, string memory venue) public view returns (uint256 price) {
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
        uint256 assetScore = getCreditScore(tokenAddress);
        (score, totalPredictionMarketSize) = (assetScore, 200);
    }

    function getPredictionMarketAssetExpirationDate(address tokenAddress) external view returns (uint256 timestamp) {
        (timestamp) = assetResolutionDates[tokenAddress];
    }

    function getPredictionBalance(address predictorAddress, address tokenAddress) public view returns (uint256 currentBalance, uint256 side){
         // placeholder for now
        (currentBalance, side) = (200, 200);
    }

    function isAssetOnAMP(address tokenAddress) public view returns (bool isOn){
        address assetAddress = assets[tokenAddress].tokenAddress;
        if (assetAddress != address(0)){
            (isOn) = true;
        } else{
            (isOn) = false;
        }
    }

    function isPredictionMarketResolved(address tokenAddress)  public view returns (bool isOn){
        uint256 resolutionDate = assetResolutionDates[tokenAddress];
        if (now > resolutionDate){
            (isOn) = true;
        } else{
            (isOn) = false;
        }

    }

    function rateEntityForCreditScore(address entityAddress, uint256 proposedScore) public returns(bool){
         // placeholder for now
        return true;
    }

    function swapAsset( address fromAsset, address toAsset, string calldata fromTokenSymbol, string calldata toTokenSymbol, uint256 amountInput, uint256 minimumOutput) external returns(uint256 outputAmount){
        // check if the contract is allowed to spend the the swap amount
        require(IERC20(fromAsset).allowance(msg.sender, address(this)) >= amountInput, 'Please approve this contract to spend the swap amount');

        // check if the contract is able to transfer the swap amount from the user to itself if the allowance is given
        require(IERC20(fromAsset).transferFrom(msg.sender, address(this), amountInput), 'Failed to transfer the from asset to the contract');

        // check if the contract is able to approve the asset for swapping in uniswap
        require(IERC20(fromAsset).approve(address(uniswapAddress), amountInput), 'Token approve failed for the token swap via uniswap.');

        uint256 finalOutputAmount = 0;
        
        // get the asset swap price via orfeed
        uint256 swapPrice = getSwapPrice(fromTokenSymbol, toTokenSymbol, amountInput, "UNISWAPBYSYMBOLV2");

        if (swapPrice < minimumOutput) {
            revert("The final output amount for this swap will be less than the minimum amount set!");
        } else {
            // start the token to token swap
                address[] memory path = new address[](2);
                path[0] = fromAsset;
                path[1] = toAsset;
                uint[] memory swapAmounts = uniswap.swapExactTokensForTokens(amountInput, minimumOutput, path, msg.sender, block.timestamp);

            for (uint i= 0; i < swapAmounts.length; i++) {
                // skip the first index amount because it will be the input amount
                if (i > 0) {
                    // add up the rest of the amounts in the array and return them
                    finalOutputAmount += swapAmounts[i];
                }
            }
        }
    
        (outputAmount) = finalOutputAmount;
    }

    function predictForOrAgainst(address tokenAddress, bool predictFor, uint256 amountStableCoinStaked) payable external returns(bool) {

        bool predicitionSuccessful = false;

        // first of all check if the contract is allow spend the dai amount set by the sender
        if(IERC20(daiToken).allowance(msg.sender, address(this)) >= amountStableCoinStaked) {

            // check if the contract is able to transfer the dai amount from the user to itself if the allowance is given
            require(IERC20(daiToken).transferFrom(msg.sender, address(this), amountStableCoinStaked), 'Failed to transfer the dai from your address to the contract for prediction');

            // if transfer is sucessful, then update the predicitions for the token for this user
            predictions[tokenAddress].push(Prediction(msg.sender, predictFor, amountStableCoinStaked));

            // mark the prediction as successful
            predicitionSuccessful = true;
        } else{
            require(msg.value > 0, "Please send some ETH that'll be swapped for dai and sused for the prediction");

            uint256 swapPrice = orfeed.getExchangeRate("ETH", "DAI", "UNISWAPBYSYMBOLV2", amountStableCoinStaked);

            if (swapPrice < amountStableCoinStaked) {
                revert("The final output amount for the ETH/DAI swap will be less than the amount of stable coins to be staked!");
            } else { 

                // start the eth to token swap
                uint256 finalOutputAmount = 0;
                address[] memory path = new address[](2);
                path[0] = uniswap.WETH();
                path[1] = address(daiToken);

                // sent uniswap the eth
                uniswapAddress.transfer(msg.value);
                
                // do the swap via uniswap v2 and get the array out the outputs
                uint[] memory swapAmounts = uniswap.swapETHForExactTokens(amountStableCoinStaked, path, address(this), block.timestamp);

                for (uint i = 0; i < swapAmounts.length; i++) {
                    // skip the first index amount because it will be the input amount
                    if (i > 0) {
                        // add up the rest of the amounts in the array and return them
                        finalOutputAmount += swapAmounts[i];
                    }
                }

                // update the users predicitions
                predictions[tokenAddress].push(Prediction(msg.sender, predictFor, amountStableCoinStaked));

                // mark the prediction as successful
                predicitionSuccessful = true;
            }
          
        }

        return predicitionSuccessful;
    }

    function resolvePredictionMarketAsset(address tokenAddress)  public returns(bool resolved) {
        uint256 resolutionDate = assetResolutionDates[tokenAddress];
        if (now > resolutionDate){
            (resolved) = true;
        } else{
            (resolved) = false;
        }

    }
    
    function addAssetToMarket(address tokenAddress, string memory title, string memory description, string memory entityName, uint256 proposedMarketCapUSD, string memory fileHash1, string memory fileHash2, string memory photo1URL, string memory photo2URL, string memory photo3URL ) public {
        // add the asset
        assets[tokenAddress] = Asset(tokenAddress, title, description, entityName, proposedMarketCapUSD, fileHash1, fileHash2, photo1URL, photo2URL, photo3URL, 0, 0);
        
        // set the token issuer
        tokenIssuers[tokenAddress] = TokenIssuer(msg.sender, now);
        
        // calculate and set  its resolution date
        uint256 resolutionDate = now + 365 days;
        assetResolutionDates[tokenAddress] = resolutionDate;
        
        // then emit the appropriate event
        emit AssetAdded(tokenAddress, resolutionDate);
    }

    function inactivateAsset(address tokenAddress, string memory reasonGivenByAdminOrCreator ) public {
       // remove the asset from the assets mapping
       delete assets[tokenAddress];
       
       // remove the issuer of the token
       delete tokenIssuers[tokenAddress];
       
       // delete its resolution date
       delete assetResolutionDates[tokenAddress];
       
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

        bool contributionSuccessful = false;

        // make sure the asset is listed on amp
        if(isAssetOnAMP(tokenAddress)) {
            // check if the contract is allowed to spend 
            require(IERC20(daiToken).allowance(msg.sender, address(this)) >= amountUSD, 'Please approve this contract to spend the contribution dai amount');

            // check if the contract is able to transfer the dai amount from the user to itself if the allowance is given
            require(IERC20(daiToken).transferFrom(msg.sender, address(this), amountUSD), 'Failed to transfer the dai from your address to the contract');

            // if the transfer is successful, then updaate the regular rewards balance for the asset/token
            assets[tokenAddress].assetRegularRewards += amountUSD;

            // then mark the contribution as successful
            contributionSuccessful = true;
        }

        return contributionSuccessful;
    }
    
    function contributeAssetSaleRewards(address tokenAddress, uint256 amountUSD) public returns(bool){
        bool contributionSuccessful = false;

        // make sure the asset is listed on amp
        if(isAssetOnAMP(tokenAddress)) {
            // check if the contract is allowed to spend the dai
            require(IERC20(daiToken).allowance(msg.sender, address(this)) >= amountUSD, 'Please approve this contract to spend the contribution dai amount');

            // check if the contract is able to transfer the dai amount from the user to itself if the allowance is given
            require(IERC20(daiToken).transferFrom(msg.sender, address(this), amountUSD), 'Failed to transfer the dai from your address to the contract');

            // if the transfer is successful, then updaate the regular rewards balance for the asset/token
            assets[tokenAddress].assetSaleRewards += amountUSD;

            // then mark the contribution as successful

            contributionSuccessful = true;
        }

        return contributionSuccessful;
    }

}