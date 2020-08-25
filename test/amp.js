const AmpContract = artifacts.require("Amp");

contract('AmpContract', async accounts => {

    let ampContract = "";
    
    before(async () => {
        ampContract = await AmpContract.deployed()
    });

    it('Should deploy smart contract properly', ()=> {

        console.log(ampContract.address);

        assert(ampContract.address != '');

    });

});