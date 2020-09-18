# AssuranceMarket2.0

Prediction and Token Swap Market for Real-World Assets

# Testing

To test the contract and verify its functionality, please do the following

1. Make sure you have [node.js](https://nodejs.org/en/) and [yarn](https://classic.yarnpkg.com/en/docs/getting-started) installed in your system.
2. Then install [truffle](https://www.trufflesuite.com/docs/truffle/getting-started/installation) globally in your system via the command `yarn global add truffle`.
3. Navigate to the root of this project and install the required node dependencies through the command `yarn install`
4. Replace the `mnemonic` variable in `truffle-config.js` with your own 12 words or more phrase, if necessary.
4. Replace the `infuraKey` variable in `truffle-config.js` with your own infura key.
5. Finally, fund the ethereum account associated with the above `mnemonic` phrase with some test `rinkeby ETH` and then run the command `truffle test --network rinkeby` to compile & deploy the contract to rinkeby and also run the tests to verify its functonality.

# Core Functionality

## getCreditScore

Returns the credit score of an Ethereum address. The credit score is an aggregation of scores submitted by users who purchase assets from a user once the asset reaches its resolution date (Date set which determines whether the original commitment by issuer was met).


## getPrice

Given a token address and venue, this function leverages orfeed to query a token price. Optionally a user can specify the venue of AMP which specifies assets that are native to AMP. This can be called for, for example, DAI, but usually this would be used for properties or other kinds of Assets. Returns price in USD. The OrFeed contract address can be updated by the owner of this contract, which is ideally operated by a DAO

## getSwapPrice

Same as getPrice, except it can be used to identify prices between a given asset and any other assets


## getProposedYield

This function returns the annual yeild percentage (100 for 1 percent, 10 for .1%) that an issuer of an asset has estimated for an asset that has been added to the assurance marketCap


## getHistoricYield

Returns the average yield based on the number of years specified. The historic yield is determined based on the rewards sent by the issuer via AMP


## getProposedMarketCap

Returns the initial market cap specified by a user of an asset that was added to the assurance market


## getAssetPredictionScoreAndSize

Returns the prediction score of an asset and total size of the prediction market. For example, if 100 DAI has been been staked predicting for an asset, while 50 has been staked against, the score will be 100/50 = 2, but 200 to account for decimals. If 50 is against and 100 predicts for, the score will be 50/100 = .5, or 50 to account for decimals. In both cases the prediction market size is 150, or 15000 to account for decimals in solidity.


## getPredictionMarketAssetResolutionDate

Returns the uint256 timestamp time representing when an assets' resolution date is (when prediction market is settled). By default this is one year from issuance of an asset on an assurance market.


## getPredictionBalance

Returns the stake a user has in a given prediction market based on a token address of an asset in the prediction market. If a user put 50.50 DAI to predict against, it will return 5050 and 0. If the user had predicted for it would return 5050 and 1.


## isAssetOnAMP

Based on a given token address, returns false if the token is not approved by the assurance market owner DAO as listed on the assurance market.


## isPredictionMarketResolved

Given a token address, returns true or false based on whether the resolution date for an assets has passed.


## rateEntityForCreditScore

Adds the rating of a user toward the issuer of a token on the assurance market. The users rating is based on their percentage of contribution to the total prediction market. If a user uploaded 2 assets that have expired an 40% of prediction market participant by volume gave a score of 0, while the other 60% gave a score of 100, then the score will be 60 when the credit score is returned. A user can rate an issuer up to 3 times per asset (after the first score, it is an update to their  sent score in case it was a mistake).


## swapAsset

Calls the getSwapPrice method (bonding curve) and then executes a trade from one asset to another, similar to how swaps occur on Uniswap.


## predictForOrAgainst

Allows a user to send ETH (which is converted to DAI via Uniswap upon receipt) or use DAI is they have approved the smart contract to handle their eth and place a prediction market position for or against an asset.


## resolvePredictionMarketAsset
Can be called by issuer or the owner DAO at any time. Can be called by any user if the resolution date for an asset has passed.


## addAssetToMarket

Given a token address, an asset is added to the assurance market


## deactivateAsset

Can be called by DAO owner contract if a fraudulent user has uploaded a token address that they are not the issuer of. Removes it from the market, so that a the real issuer can later upload it.


## claimPredictionRewards

Can be called by a prediction market prediction holder to retrieve their resolution reward based on results of a prediction market after resolution.

## claimAssetRewards

Can be called by token holder of an asset, and the amount that is returned in DAI to the user is the amount the issuer has deposited to the rewards pool. The amount the issuer deposited is used to determine the yield amount.


## claimAssetSaleRewards

Can be called by a token holder of an asset, and the amount that is transferred to the user is based on the amount an issuer has placed in a sales pool based on a token underlying asset sale.


## contributeAssetRegularRewards

Can be contributed by issuer or anyone else (DAI) that can later be claimed proportionately by token holders of a given asset when calling claimAssetRewards

## contributeAssetSaleRewards

Can be contributed by issuer or anyone else (DAI) that can later be claimed proportionately by token holders of a given asset when calling claimAssetSaleRewards
