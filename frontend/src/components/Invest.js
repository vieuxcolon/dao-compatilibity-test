import { ethers } from "ethers";

export default function Invest({ dao }) {
  const invest = async () => {
    const tx = await dao.invest({
      value: ethers.parseEther("0.01")
    });
    await tx.wait();
    alert("Invested 0.01 ETH");
  };

  return (
    <div>
      <h3>💰 Invest</h3>
      <button onClick={invest}>Invest 0.01 ETH</button>
    </div>
  );
}
