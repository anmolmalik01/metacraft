import "./App.css";
import { ethers } from "ethers";
import { useEffect, useState, useCallback } from "react";
import MyContract from "./contracts/SakshamContract.sol/SakshamContract.json";

function App() {
  const [ownerName, setOwnerName] = useState("");
  const [ownerBalance, setOwnerBalance] = useState("");
  const [transferAmount, setTransferAmount] = useState("");
  const [withdrawAmount, setWithdrawAmount] = useState("");
  const [selectedAddress, setSelectedAddress] = useState(undefined);
  const [contract, setContract] = useState("");
  const abi = MyContract.abi;

  const contractAddress = "0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512"; // Replace with your contract address

  const connectWallet = useCallback(async () => {
    try {
      const { ethereum } = window;
      if (!ethereum) {
        alert("Please install the MetaMask extension");
        return;
      }

      const [selectedAddress] = await ethereum.request({
        method: "eth_requestAccounts",
      });

      setSelectedAddress(selectedAddress);

      const provider = new ethers.providers.Web3Provider(ethereum);
      const signer = provider.getSigner();
      const contract = new ethers.Contract(contractAddress, abi, signer);
      setContract(contract);
    } catch (error) {
      console.error(error);
    }
  }, [abi]);

  useEffect(() => {
    connectWallet();
  }, [connectWallet]);

  useEffect(() => {
    async function fetchOwnerData() {
      if (contract) {
        const name = await contract.contractOwner();
        setOwnerName(name);

        const balance = await contract.getOwnerBalance();
        setOwnerBalance(ethers.utils.formatEther(balance.toString()));
      }
    }
    fetchOwnerData();
  }, [contract]);

  window.ethereum.on("accountsChanged", (accounts) => {
    if (accounts[0] && accounts[0] !== selectedAddress) {
      connectWallet();
    }
  });

  async function handleTransfer() {
    try {
      if (!contract) {
        alert("Please connect your wallet first");
        return;
      }

      if (!transferAmount || transferAmount <= 0) {
        alert("Transfer amount should be greater than 0");
        return;
      }

      const value = ethers.utils.parseEther(transferAmount);
      const transaction = await contract.transferFunds({
        value,
      });

      await transaction.wait();

      const balance = await contract.getOwnerBalance();
      setOwnerBalance(ethers.utils.formatEther(balance.toString()));

      alert("Transfer successful!");
    } catch (error) {
      console.error(error);
      alert("Transfer failed");
    }
  }

  async function handleWithdraw() {
    try {
      if (!contract) {
        alert("Please connect your wallet first");
        return;
      }

      if (!withdrawAmount || withdrawAmount <= 0) {
        alert("Withdrawal amount should be greater than 0");
        return;
      }

      const value = ethers.utils.parseEther(withdrawAmount);
      const transaction = await contract.withdrawFunds({
        value,
      });

      await transaction.wait();

      const balance = await contract.getOwnerBalance();
      setOwnerBalance(ethers.utils.formatEther(balance.toString()));

      alert("Withdrawal successful!");
    } catch (error) {
      console.error(error);
      alert("Withdrawal failed");
    }
  }

  return (
    <main className="app-container">
      <h1 className="title">EtherVerse</h1>
      <div className="owner-info">
        <h2 className="owner-heading">Owner: {ownerName}</h2>
        <p className="balance">Balance: {ownerBalance} ETH</p>
      </div>
      <div className="transfer-section">
        <label htmlFor="transfer" className="label">
          Transfer Amount
        </label>
        <div className="transfer-input">
          <input
            type="number"
            id="transfer"
            inputMode="numeric"
            value={transferAmount}
            onChange={(e) => {
              setTransferAmount(e.target.value);
            }}
            className="input-field"
          />
          <span className="ether">ETH</span>
        </div>
        <button className="button" onClick={handleTransfer}>
          Deposit
        </button>
      </div>
      <div className="transfer-section">
        <label htmlFor="withdraw" className="label">
          Withdraw Amount
        </label>
        <div className="transfer-input">
          <input
            type="number"
            id="withdraw"
            inputMode="numeric"
            value={withdrawAmount}
            onChange={(e) => {
              setWithdrawAmount(e.target.value);
            }}
            className="input-field"
          />
          <span className="ether">ETH</span>
        </div>
        <button className="button" onClick={handleWithdraw}>
          Withdraw
        </button>
      </div>
      <button className="connect-button" onClick={connectWallet}>
        Connect to Wallet
      </button>
    </main>
  );
}

export default App;
