import { useEffect, useState } from "react";
import ProposalItem from "./ProposalItem";

export default function ProposalList({ dao }) {
  const [proposals, setProposals] = useState([]);

  useEffect(() => {
    loadProposals();
  }, []);

  const loadProposals = async () => {
    const count = await dao.proposalCount();
    const items = [];

    for (let i = 0; i < count; i++) {
      const proposal = await dao.proposals(i);
      const votes = await dao.getProposalVotes(i);

      items.push({
        id: i,
        description: proposal.description,
        amount: proposal.amount,
        executed: proposal.executed,
        votesFor: votes[0],
        votesAgainst: votes[1]
      });
    }

    setProposals(items);
  };

  return (
    <div>
      <h3>🗳 Proposals</h3>
      {proposals.map(p => (
        <ProposalItem key={p.id} proposal={p} dao={dao} />
      ))}
    </div>
  );
}
