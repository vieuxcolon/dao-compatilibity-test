import { ethers } from "ethers";

export default function ProposalItem({ proposal, dao }) {
  const vote = async (support) => {
    const tx = await dao.vote(proposal.id, support);
    await tx.wait();
    alert("Vote submitted");
  };

  const execute = async () => {
    const tx = await dao.executeProposal(proposal.id);
    await tx.wait();
    alert("Proposal executed");
  };

  return (
    <div style={{ border: "1px solid gray", margin: "10px", padding: "10px" }}>
      <p><strong>{proposal.description}</strong></p>
      <p>Amount: {ethers.formatEther(proposal.amount)} ETH</p>
      <p>For: {proposal.votesFor.toString()}</p>
      <p>Against: {proposal.votesAgainst.toString()}</p>

      {!proposal.executed && (
        <>
          <button onClick={() => vote(true)}>Vote For</button>
          <button onClick={() => vote(false)}>Vote Against</button>
          <button onClick={execute}>Execute</button>
        </>
      )}
    </div>
  );
}
