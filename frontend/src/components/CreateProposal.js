import { useState } from "react";
import { ethers } from "ethers";

export default function CreateProposal({ dao }) {
  const [description, setDescription] = useState("");
  const [amount, setAmount] = useState("");

  const createProposal = async () => {
    const tx = await dao.createProposal(
      description,
      ethers.parseEther(amount)
    );
    await tx.wait();
    alert("Proposal created");
  };

  return (
    <div>
      <h3>📜 Create Proposal</h3>
      <input
        placeholder="Description"
        value={description}
        onChange={e => setDescription(e.target.value)}
      />
      <input
        placeholder="Amount (ETH)"
        value={amount}
        onChange={e => setAmount(e.target.value)}
      />
      <button onClick={createProposal}>Submit</button>
    </div>
  );
}
