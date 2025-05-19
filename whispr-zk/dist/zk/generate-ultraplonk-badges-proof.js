"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const fs_1 = __importDefault(require("fs"));
const path_1 = __importDefault(require("path"));
const noir_js_1 = require("@noir-lang/noir_js");
const bb_js_1 = require("@aztec/bb.js"); // mesmo pacote, mas nome de export pode variar
async function main() {
    // 1) Carrega o circuito (ACIR + bytecode)
    const circuitPath = path_1.default.resolve(__dirname, "../../circuits/badges/target/circuits.json");
    const circuit = JSON.parse(fs_1.default.readFileSync(circuitPath, "utf8"));
    // 2) Carrega a saída da Merkle-Tree (output/tree.json)
    const tree = JSON.parse(fs_1.default.readFileSync(path_1.default.resolve(__dirname, "../../output/tree.json"), "utf8"));
    // 3) Execute o circuito para montar o witness (badgeId=5)
    const badge5 = tree.proofs.find((p) => p.badgeId == 5);
    const noir = new noir_js_1.Noir(circuit);
    const { witness } = await noir.execute({
        badgeId: badge5.badgeId,
        descHash: badge5.descHash,
        proof_nodes: badge5.siblings,
        proof_indices: badge5.pathIndices,
    });
    // 4) Gere a prova UltraPlonk
    const backend = new bb_js_1.UltraPlonkBackend(circuit.bytecode);
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
    const outDir = path_1.default.resolve(__dirname, "../../circuits/bagdes/target");
    fs_1.default.mkdirSync(outDir, { recursive: true });
    fs_1.default.writeFileSync(path_1.default.join(outDir, "proof.bin"), proof);
    fs_1.default.writeFileSync(path_1.default.join(outDir, "public.json"), JSON.stringify(publicInputs, null, 2));
    fs_1.default.writeFileSync(path_1.default.join(outDir, "proof-data.json"), JSON.stringify(output, null, 2), "utf8");
    fs_1.default.writeFileSync(path_1.default.join(outDir, "circuits.vk"), JSON.stringify(vk, null, 2));
    fs_1.default.writeFileSync(path_1.default.join(outDir, "circuits.proof"), JSON.stringify(proof, null, 2));
    fs_1.default.writeFileSync(path_1.default.join(outDir, "vk.hex"), vkHex, "utf8");
    console.log("✅ Prova UltraPlonk gerada em", outDir);
    backend.destroy();
}
main().catch(console.error).finally;
