import HDWalletProvider from '@truffle/hdwallet-provider';

// replace with own infura key
const infuraKey = "1b159090386c48bbb7828f1b346dcc11";

// this mnemonic is for testing purposes only please replace with yours if you want to deploy to mainnet
const mnemonic = "trip movie level talk two carbon curve include shed noble paddle stomach bean sibling dinner";

// current account for above phrase is 0xb32809CB3B27d80D15E1c4169957758a460C2b02

export const networks = {
  rinkeby: {
    provider: () => new HDWalletProvider(mnemonic, `https://rinkeby.infura.io/v3/${infuraKey}`),
    network_id: 4,
    gas: 5500000,
    confirmations: 1,
    timeoutBlocks: 200
  }
};
export const mocha = {
  // timeout: 100000
};
export const compilers = {
  solc: {
    version: "0.6.6",
  }
};
