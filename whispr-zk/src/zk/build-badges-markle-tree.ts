import { buildPoseidon } from "circomlibjs";
import { IMT }          from "@zk-kit/imt";
import { keccak256, toUtf8Bytes } from "ethers";
import { mkdir, writeFile } from "fs/promises";
import badges from "./badges";

async function main() {
  // 1) Inicializa Poseidon
  const poseidon = await buildPoseidon();
  const F        = poseidon.F;

  // 2) Função compatível com IMT
  function poseidonHash(values: (number|string|bigint)[]): bigint {
    const bigs = values.map(v => BigInt(v));
    const hashed = poseidon(bigs);
    return F.toObject(hashed);
  }

  // 3) Parâmetros da árvore
  const depth     = 4;                 // altura → até 16 folhas
  const zeroValue = BigInt(0);         // valor zero para leaves faltantes
  const arity     = 2;                 // binária

  // 5) Calcula as folhas: Poseidon([ id, keccak256(desc) ])
  const leaves = badges.map(({ id, name }) => {
    const descHashHex    = keccak256(toUtf8Bytes(name));
    const descHashBigInt = BigInt(descHashHex);
    return poseidonHash([ id, descHashBigInt ]);
  });

  // 6) Instancia a Merkle Tree
  const tree = new IMT(poseidonHash, depth, zeroValue, arity, leaves);

  // 7) Prepara objeto de saída
  const output = {
    root: tree.root.toString(),
    leaves: leaves.map(l => l.toString()),
    proofs: badges.map(({ id }, idx) => {
      const proof = tree.createProof(idx);
      return {
        badgeId: id,
        siblings: proof.siblings.map(s => s.toString()),
        pathIndices: proof.pathIndices
      };
    })
  };

  // 8) Garante diretório 'output'
  await mkdir("output", { recursive: true });

  // 9) Escreve em output/tree.json
  await writeFile(
    "output/tree.json",
    JSON.stringify(output, null, 2),
    "utf8"
  );

  console.log("Merkle tree data saved to output/tree.json");
}

main().catch(err => {
  console.error(err);
  process.exit(1);
});
