require('@nomiclabs/hardhat-waffle');
require('hardhat-abi-exporter');

// Replace this private key with your Mumbai wallet private key
const MUMBAI_PRIVATE_KEY = '';

// Replace this with your Datahub api key
const DATAHUB_API_KEY = 'c52cc8a2cb9cad03963bc701423a1e67';

module.exports = {
  solidity: '0.8.0',
  abiExporter: {
    path: './abi/',
    clear: true,
  },
  networks: {
    mumbai: {
      url: `https://matic-mumbai--jsonrpc.datahub.figment.io/apikey/${DATAHUB_API_KEY}`,
      accounts: [`0x${MUMBAI_PRIVATE_KEY}`],
    },
  },
};