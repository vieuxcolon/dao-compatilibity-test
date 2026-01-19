// hardhat.config.js  USE THIS
import '@nomicfoundation/hardhat-toolbox';
import dotenv from 'dotenv';

dotenv.config();

export default {
  solidity: '0.8.20',
  networks: {
    localhost: {
      url: 'http://127.0.0.1:8545'
    }
  }
};
