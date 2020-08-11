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



contract AMP{

  using SafeMath
    for uint256;

    function getCreditScore(address entityAddress) public view returns (uint256 score){

    }

    function getPrice(address tokenAddress, uint256 amount, uint256 side, string memory venue) public view returns (uint256 price){

    }

    function getSwapPrice(address fromTokenAddress, address toTokenAddress, uint256 amount, uint256 side, string memory venue) public view returns (uint256 price){

    }


    function getProposedYield(address tokenAddress) public view returns (uint256 percentage){

    }

    function getHistoricYield(address tokenAddress, uint256 years) public view returns (uint256 percentage){

    }

    function getProposedMarketCap(address tokenAddress) public view returns (uint256 marketCap){

    }

    function getAssetPredictionScoreAndSize(address tokenAddress)  public view returns (uint256 score, uint256 totalPredictionMarketSize){

    }

    function getPredictionMarketAssetExpirationDate() public view returns (uint256 timestamp){

    }

    function getPredictionBalance(address predictorAddress, address tokenAddress) public view returns (uint256 currentBalance, uint256 side){


    }


    function isAssetOnAMP(address tokenAddress)  public view returns (bool isOn){

    }

    function isPredictionMarketResolved(address tokenAddress)  public view returns (bool isOn){

    }


    function rateEntityForCreditScore(address entityAddress, uint256 proposedScore) public returns(bool){

    }

    function swapAsset(address toAsset, address fromAsset, uint256 amountInput, int256 minimumOutput) public returns(uint256 outputAmount){

    }

    function predictForOrAgainst(address tokenAddress, bool predictFor, uint256 amountStableCoinStaked) public returns(bool){

    }

    function resolvePredictionMarketAsset(address tokenAddress)  public returns(bool resolved){

    }

    function addAssetToMarket(address tokenAddress, string memory title, string memory description, string memory entityName, uint256 proposedMarketCapUSD, string memory fileHash1, string memory fileHash2, string memory photo1URL, string memory photo2URL, string memory photo3URL ) public {

    }


    function inactivateAsset(address tokenAddress, string memory reasonGivenByAdminOrCreator ) public {

    }

    function claimPredictionRewards(address tokenAddress) public returns(uint256 amountReturned){

    }

    function claimAssetRewards(address tokenAddress) public returns(uint256 amountReturned){

    }

    function claimAssetSaleRewards(address tokenAddress) public returns(uint256 amountReturned){

    }

    function contributeAssetRegularRewards(address tokenAddress, uint256 amountUSD) public returns(bool){

    }
    function contributeAssetSaleRewards(address tokenAddress, uint256 amountUSD) public returns(bool){

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
