import fs from "fs";
import path from "path";
import { Noir } from "@noir-lang/noir_js";
import { UltraPlonkBackend } from "@aztec/bb.js"; // mesmo pacote, mas nome de export pode variar

async function main() {
  // 1) Carrega o circuito (ACIR + bytecode)
  const circuitPath = path.resolve(
    __dirname,
    "../../circuits/target/circuits.json"
  );
  const circuit = JSON.parse(fs.readFileSync(circuitPath, "utf8"));

  // 2) Carrega a saída da Merkle-Tree (output/tree.json)
  const tree = JSON.parse(
    fs.readFileSync(path.resolve(__dirname, "../../output/tree.json"), "utf8")
  );

  // 3) Execute o circuito para montar o witness (badgeId=5)
  const badge5 = tree.proofs.find((p: any) => p.badgeId == 5);
  const noir = new Noir(circuit);
  const { witness } = await noir.execute({
    badgeId: badge5.badgeId,
    descHash: badge5.descHash,
    proof_nodes: badge5.siblings,
    proof_indices: badge5.pathIndices,
  });

  // 4) Gere a prova UltraPlonk
  const backend = new UltraPlonkBackend(circuit.bytecode);
  const { proof, publicInputs } = await backend.generateProof(witness);

  // Verifique a prova localmente
  const isValid = await backend.verifyProof({ proof, publicInputs });
  console.log(`Prova é ${isValid ? "válida" : "inválida"} ✅`);

  // Conversão para formato hexadecimal
  const vk = await backend.getVerificationKey();
  const proofHex = "0x" + Buffer.from(proof).toString("hex");
  const vkHex = "0x" + Buffer.from(vk).toString("hex");

  console.log(`Prova em hex: ${proofHex}`);
  console.log(`Chave de verificação: ${vkHex}`);

  // Constrói o JSON dos hashes vk e proof
  const output = {
    vk: vkHex,
    proof: proofHex,
  };

  // 5) Salve os artefatos
  const outDir = path.resolve(__dirname, "../../circuits/target");
  fs.mkdirSync(outDir, { recursive: true });
  fs.writeFileSync(path.join(outDir, "proof.bin"), proof);
  fs.writeFileSync(
    path.join(outDir, "public.json"),
    JSON.stringify(publicInputs, null, 2)
  );
  fs.writeFileSync(
    path.join(outDir, "proof-data.json"),
    JSON.stringify(output, null, 2),
    "utf8"
  );
  fs.writeFileSync(
    path.join(outDir, "circuits.vk"),
    JSON.stringify(vk, null, 2)
  );
  fs.writeFileSync(
    path.join(outDir, "circuits.proof"),
    JSON.stringify(proof, null, 2)
  );
  fs.writeFileSync(path.join(outDir, "vk.hex"), vkHex, "utf8");

  console.log("✅ Prova UltraPlonk gerada em", outDir);

  backend.destroy();
}

main().catch(console.error).finally;
