"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const circomlibjs_1 = require("circomlibjs");
const imt_1 = require("@zk-kit/imt");
const ethers_1 = require("ethers");
const promises_1 = require("fs/promises");
const badges_1 = __importDefault(require("./badges"));
async function main() {
    // 1) Inicializa Poseidon
    const poseidon = await (0, circomlibjs_1.buildPoseidon)();
    const F = poseidon.F;
    // 2) Função compatível com IMT
    function poseidonHash(values) {
        const bigs = values.map((v) => BigInt(v));
        const hashed = poseidon(bigs);
        return F.toObject(hashed);
    }
    // 3) Parâmetros da árvore
    const depth = 4; // altura → até 16 folhas
    const zeroValue = BigInt(0); // valor zero para leaves faltantes
    const arity = 2; // binária
    // 4) Calcule descHash para cada descrição (Keccak256 off-chain)
    // Constante do campo BN254
    const FIELD_PRIME = BigInt("21888242871839275222246405745257275088548364400416034343698204186575808495617");
    const descHashes = badges_1.default.map(({ name }) => {
        const descHashHex = (0, ethers_1.keccak256)((0, ethers_1.toUtf8Bytes)(name));
        const raw = BigInt(descHashHex);
        return raw % FIELD_PRIME;
    });
    // 5) Calcula as folhas: Poseidon([ id, keccak256(desc) ])
    const leaves = badges_1.default.map(({ id, name }) => {
        const descHashHex = (0, ethers_1.keccak256)((0, ethers_1.toUtf8Bytes)(name));
        const descHashBigInt = BigInt(descHashHex);
        return poseidonHash([id, descHashBigInt]);
    });
    // 6) Instancia a Merkle Tree
    const tree = new imt_1.IMT(poseidonHash, depth, zeroValue, arity, leaves);
    // 7) Prepara objeto de saída
    const output = {
        root: tree.root.toString(),
        leaves: leaves.map((l) => l.toString()),
        proofs: badges_1.default.map(({ id }, idx) => {
            const proof = tree.createProof(idx);
            return {
                badgeId: id,
                descHash: descHashes[idx].toString(),
                siblings: proof.siblings.map((s) => s.toString()),
                pathIndices: proof.pathIndices,
            };
        }),
    };
    // 8) Garante diretório 'output'
    await (0, promises_1.mkdir)("output", { recursive: true });
    // 9) Escreve em output/tree.json
    await (0, promises_1.writeFile)("output/tree.json", JSON.stringify(output, null, 2), "utf8");
    console.log("Merkle tree data saved to output/tree.json");
}
main().catch((err) => {
    console.error(err);
    process.exit(1);
});
