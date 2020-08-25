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

interface IAMP {
    /*
    * @notice allow the owner to set the address of the orfeed contract
    * @param _orfeedAddress the new address of the orfeed contract
    * @return true
    */
    function setOrfeedAddress(address _orfeedAddress) onlyOwner external returns(bool)

    /*
    * @dev Returns the credit score of an Ethereum address.
    */
    function getCreditScore(address entityAddress) public view returns (uint256)

    /*
    * @dev Returns the credit score of an Ethereum address.
    */
    function getPrice(address tokenAddress, uint256 amount, string memory venue) public view returns (string)

    /*
    * @dev Same as getPrice, except it can be used to identify prices between a given asset and any other assets.
    */
    function getSwapPrice(address fromTokenAddress, address toTokenAddress, uint256 amount, string memory venue) public view returns (uint256)

    /*
    * @dev Returns the annual yeild percentage that an issuer of an asset has estimated for an asset that has been added to the assurance marketCap.
    */
    function getProposedYield(address tokenAddress) public view returns (uint256)

    /*
    * @dev Returns the average yield based on the number of years specified.
    */
    function getHistoricYield(address tokenAddress, uint256 numOfYears) public view returns (uint256)

    /*
    * @dev Returns the initial market cap specified by a user of an asset that was added to the assurance market.
    */
    function getProposedMarketCap(address tokenAddress) external view returns (uint256)

    /*
    * @dev Returns the prediction score of an asset and total size of the prediction market.
    */
    function getAssetPredictionScoreAndSize(address tokenAddress)  external view returns (uint256, uint256)

    /*
    * @dev Returns the uint256 timestamp time representing when an assets' resolution date is.
    */
    function getPredictionMarketAssetExpirationDate(address tokenAddress) external view returns (uint256)

    /*
    * @dev Returns the stake a user has in a given prediction market based on a token address of an asset in the prediction market.
    */
    function getPredictionBalance(address predictorAddress, address tokenAddress) public view returns (uint256 currentBalance, uint256)

    /*
    *  @dev Returns false if the token is not approved by the assurance market owner DAO as listed on the assurance market.
    */
    function isAssetOnAMP(address tokenAddress)  public view returns (bool)

    /*
    * @dev Returns true or false based on whether the resolution date for an assets has passed.
    */

    function isPredictionMarketResolved(address tokenAddress)  public view returns (bool)


    /*
    * @dev Adds the rating of a user toward the issuer of a token on the assurance market.
    */
    function rateEntityForCreditScore(address entityAddress, uint256 proposedScore) public returns(bool)

    /*
    * @dev Calls the getSwapPrice method (bonding curve) and then executes a trade from one asset to another, similar to how swaps occur on Uniswap.
    */
    function swapAsset( address fromAsset, address toAsset, uint256 amountInput, uint256 minimumOutput) external returns(uint256)

    /*
    * @dev Allows a user to send ETH (which is converted to DAI via Uniswap upon receipt) or use DAI is they have approved the smart contract to handle their eth and place a prediction market position for or against an asset.
    */
    function predictForOrAgainst(address tokenAddress, bool predictFor, uint256 amountStableCoinStaked) payable external returns(bool)

    /*
    * @dev Can be called by issuer or the owner DAO at any time. Can be called by any user if the resolution date for an asset has passed.
    */
    function resolvePredictionMarketAsset(address tokenAddress)  public returns(bool resolved)

    /*
    * @dev Given a token address, an asset is added to the assurance market.
    */
    function addAssetToMarket(address tokenAddress, string memory title, string memory description, string memory entityName, uint256 proposedMarketCapUSD, string memory fileHash1, string memory fileHash2, string memory photo1URL, string memory photo2URL, string memory photo3URL ) public

    /*
    * @dev Removes assey from the market.
    */
    function inactivateAsset(address tokenAddress, string memory reasonGivenByAdminOrCreator ) public

    /*
    * @dev Can be called by a prediction market prediction holder to retrieve their resolution reward based on results of a prediction market after resolution.
    */
    function claimPredictionRewards(address tokenAddress) public returns(uint256 amountReturned)

    /*
    * @dev Can be called by token holder of an asset, and the amount that is returned in DAI to the user is the amount the issuer has deposited to the rewards pool.
    */
    function claimAssetRewards(address tokenAddress) public returns(uint256 amountReturned)

    /*
    * @dev Can be called by a token holder of an asset, and the amount that is transferred to the user is based on the amount an issuer has placed in a sales pool based on a token underlying asset sale.
    */
    function claimAssetSaleRewards(address tokenAddress) public returns(uint256 amountReturned)

    /*
    * @dev Can be contributed by issuer or anyone else and can later be claimed proportionately by token holders of a given asset when calling claimAssetRewards.
    */
    function contributeAssetRegularRewards(address tokenAddress, uint256 amountUSD) public returns(bool)

    /*
    * @dev Can be contributed by issuer or anyone else (DAI) that can later be claimed proportionately by token holders of a given asset when calling claimAssetSaleRewards.
    */
    function contributeAssetSaleRewards(address tokenAddress, uint256 amountUSD) public returns(bool)

    // contract events
    event AssetAdded(address _tokenAddress, uint256 _resolutionDate);
    event AssetInactivated(address _tokenAddress, string _reasonGivenByAdminOrCreator);

}
