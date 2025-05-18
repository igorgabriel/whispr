use std::hash::poseidon;

// Circuito para validar membership em Merkle Tree de badges
// badgeId: ID do badge
// descHash: Field with Keccak256(description)
// proof_nodes: array de siblings do Merkle path
// proof_indices: array de indices (0 esquerda, 1 direita)
fn main(
    badgeId: Field,
    descHash: Field,
    proof_nodes: [Field; 4],
    proof_indices: [u8; 4],
) {
    // root hardcoded
    let root: Field = 7431307243485218672597359909053805874708073693282662211616124471416675932364;

    // 1) Calcula o leaf via Poseidon(BN254)
    let mut node = poseidon::bn254::hash_2([badgeId, descHash]);

    // 2) Verifica o caminho Merkle
    for i in 0..4 {
        let sibling = proof_nodes[i];
        if proof_indices[i] == 1 {
            // node eh o filho direito
            node = poseidon::bn254::hash_2([sibling, node]);
        } else {
            // node eh o filho esquerdo
            node = poseidon::bn254::hash_2([node, sibling]);
        }
    }

    // 3) Verifica se o root computado bate com o root publico
    assert(node == root);
}

#[test]
fn test_valid_membership_for_badge_3() {

   let badgeId: Field = 3;
    let descHash: Field = 3116905491025972517906843997974304165568311340639809210778877064475363658994;
    let proof_nodes: [Field; 4] = [
        312748682234366520917021603254842120214010472766644107296968030420102950579,
        421251666650478583019422558988034340581060463768834437487025000486578291138,
        11103646364228013391741196488009387933299102733592066644067368558664913130812,
        18837879509182806888829077402235962425120718943028752135635254464375331023545
    ];
    let proof_indices: [u8; 4] = [0, 1, 0, 0];

    // chama o circuito como se fosse a main
    main(badgeId, descHash, proof_nodes, proof_indices);
}

#[test(should_fail)]
fn test_valid_membership_for_badge_3_fail() {

   let badgeId: Field = 3;
    let descHash: Field = 3116905491025972517906843997974304165568311340639809210778877064475363658995;
    let proof_nodes: [Field; 4] = [
        312748682234366520917021603254842120214010472766644107296968030420102950579,
        421251666650478583019422558988034340581060463768834437487025000486578291138,
        11103646364228013391741196488009387933299102733592066644067368558664913130812,
        18837879509182806888829077402235962425120718943028752135635254464375331023545
    ];
    let proof_indices: [u8; 4] = [0, 1, 0, 0];

    // chama o circuito como se fosse a main
    main(badgeId, descHash, proof_nodes, proof_indices);
}