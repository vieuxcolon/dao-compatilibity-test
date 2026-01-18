import React, { useState } from "react";
import { ethers } from "ethers";
import InvestmentDAOJson from "../contracts/InvestmentDAO.json";

const daoAddress = "PUT_DEPLOYED_CONTRACT_ADDRESS_HERE";

function App() {
  const [provider, setProvider] = useState(null);
  const [signer, setSigner] = useState(null);
  const [daoContract, setDaoContract] = useState(null);
  const [shares, setShares] = useState(0);

  const connectWallet = async () => {
    if (window.ethereum) {
      const prov = new ethers.BrowserProvider(window.ethereum);
      setProvider(prov);
      const signer = await prov.getSigner();
      setSigner(signer);
      const contract = new ethers.Contract(daoAddress, InvestmentDAOJson.abi, signer);
      setDaoContract(contract);
    } else {
      alert("Install MetaMask!");
    }
  };

  const invest = async () => {
    if (!daoContract) return;
    const tx = await daoContract.invest({ value: ethers.parseEther("0.01") });
    await tx.wait();
    alert("Invested 0.01 ETH!");
  };

  return (
    <div style={{ padding: 20 }}>
      <h1>Investment DAO</h1>
      <button onClick={connectWallet}>Connect Wallet</button>
      <button onClick={invest}>Invest 0.01 ETH</button>
      <p>Your shares: {shares}</p>
    </div>
  );
}

export default App;
