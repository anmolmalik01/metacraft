# SakshamContract

SakshamContract is a Solidity smart contract that offers various functionalities, including connecting to a MetaMask wallet, depositing and withdrawing ETH, performing mathematical operations, and more.

## Prerequisites

- Solidity: Version ^0.8.9 or a compatible version.
- Ethereum: A compatible Ethereum network or development environment.
- Remix (optional): A Solidity IDE for compiling and deploying the contract.

## Getting Started

1. Clone the repository:

   ```bash
   git clone https://github.com/your-username/SakshamContract.git
   ```

2. Navigate to the project directory:

   ```bash
   cd SakshamContract
   ```

3. Update the contract as per your requirements in the `SakshamContract.sol` file.

4. Compile the contract using a Solidity compiler of your choice.

5. Deploy the contract on your desired Ethereum network or development environment.

## Setting up a Local Host Network and Dummy Account in MetaMask Wallet

To interact with SakshamContract on a local network, follow these steps to set up a local host network and import a dummy account into your MetaMask Wallet:

1. Install the MetaMask browser extension if it is not already installed.

2. Open MetaMask and click on the network selection button located in the top-middle section.

3. Click on "Add a Network".

4. Click on "Add a Network Manually".

5. Fill in the following details:
   - Network Name: Choose a name for your local network.
   - New RPC URL: http://127.0.0.1:8545/
   - Chain ID: 31337
   - Currency Symbol: ETH

6. Click "Save" to add the local network.

7. In the terminal where you executed the command `npx hardhat node`, you will find a list of accounts along with their private keys. Choose any account's private key to import it into your MetaMask Wallet.

8. Open your MetaMask Wallet, click on the account icon in the top-right corner.

9. Click on "Import Account" and enter the private key corresponding to the chosen account.

10. Your dummy account is now imported into MetaMask.

11. Visit http://localhost:3000/ to start interacting with the MetaMask Wallet and SakshamContract.

12. You can also view all transaction details in the deploy terminal.

## Executing the DApp

To run the DApp, follow these steps:

1. Install the project dependencies by running the following command:

   ```bash
   npm install
   ```

2. Start a blockchain locally by running the command:

   ```bash
   npx hardhat node
   ```

3. Deploy the SakshamContract smart contract by running the deployment script:

   ```bash
   npx hardhat run scripts/deploy.js --network localhost
   ```

4. Go to the frontend directory by running the command:

   ```bash
   cd ./frontend
   ```

5. Install the project dependencies by running the following command:

   ```bash
   npm install
   ```

6. Start the React development server:

   ```bash
   npm start
   ```

7. The DApp will be accessible in your web browser at http://localhost:3000.

## License

This project is licensed under the [MIT License](https://opensource.org/licenses/MIT).
