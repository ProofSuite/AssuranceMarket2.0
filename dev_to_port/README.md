# AMP -> AMP2.0 Contract Ports

In the interest of expediting certain development tasks, select contracts
from AMP should be ported to the new 2.0 interfaces and contracts. For this
process, there are two primary change types:

* The first type is version porting which is simply updating older Solidity
code to the more current syntax and usage based on **industry** and
**technological** standards.  This includes utilizing visibility and

* The second type is protocol porting where functionality is changed in order
to enhance **amp2.0 protocol & practice**.  

# Filetree
In order to maintain testability, certain util and interfaces that are
standardized across the industry are included in the port process.

SafeMath.sol
root is `AssuranceMarket2.0/dev_to_port`

## Version Porting

All modules in AMP need to be ported to at least 0.6.x.  Depending on the needs
of any support lib contracts/modules, the target version should be set before
or after the integration into the main contract ecosystem.

| Name | Current Version | Target Version | isPorted |
| --- | ---| --- | --- |
| `interfaces/ERC20.sol`                    | 0.4.24 | 0.6.6 | x |
| `interfaces/ProofToken.sol`               | 0.4.24 | 0.6.6 | x |
| `interfaces/RewardCollectorInterface.sol` | 0.4.24 | 0.6.6 | x |
| `utils/ApproveAndCallReceiver.sol`        | 0.4.24 | 0.6.6 | x |
| `utils/Controlled.sol`                    | 0.4.24 | 0.6.6 | x |
| `utils/Owned.sol`                         | 0.4.24 | 0.6.6 | x |
| `utils/SafeMath.sol`                      | 0.4.24 | 0.6.6 | x |
| `utils/WETH9.sol`                         | 0.4.24 | 0.6.6 | x |
| `RewardCollector.sol`                     | 0.4.24 | 0.6.6 | x |
| `RewardPools.sol`                         | 0.4.24 | 0.6.6 | x |


## AMP2.0 Compatibility

* `ProofToken.sol` should be updated to `Mintable.sol` in order to support a more
generic reward pool.  This requires functionality with the current
Proof Interfaces.

* `RewardPools.sol` See Above

* `RewardCollector` needs to have compatibility with the `claimPredictionRewards`
and `claimAssetRewards` and `claimAssetSaleRewards` function calls from the
`amp.sol` Smart Contract.

Original code can be found at:

https://github.com/ProofSuite/amp-dex/tree/develop/contracts
