"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const dotenv_1 = __importDefault(require("dotenv"));
const api_1 = require("@polkadot/api");
const util_crypto_1 = require("@polkadot/util-crypto");
const circomlibjs_1 = require("circomlibjs");
dotenv_1.default.config();
const app = (0, express_1.default)();
app.use(express_1.default.json());
const ROOT = BigInt(process.env.ROOT || '123');
// Polkadot API singleton
let api;
async function getApi() {
    if (!api) {
        await (0, util_crypto_1.cryptoWaitReady)();
        const wsUrl = process.env.ZKVERIFY_WS_URL;
        if (!wsUrl)
            throw new Error("ZKVERIFY_WS_URL não definido no .env");
        const provider = new api_1.WsProvider(wsUrl);
        api = await api_1.ApiPromise.create({ provider });
    }
    return api;
}
// Função para verificar se o statementHash foi verificado on-chain
async function isProofVerified(statementHash) {
    const api = await getApi();
    const state = await api.query.settlementUltraplonkPallet.statementStates(statementHash);
    // Ajuste conforme o enum do pallet
    // O state é um enum; converta para string/JSON e compare
    const result = state.toString();
    return result === "Verified";
}
// Rota para validar badge
app.post("/validateBadge", async (req, res) => {
    const { statementHash } = req.body;
    if (typeof statementHash !== "string") {
        return res
            .status(400)
            .json({ error: "statementHash deve ser uma string" });
    }
    try {
        const valid = await isProofVerified(statementHash);
        return res.json({ valid });
    }
    catch (err) {
        console.error("Erro ao verificar badge:", err);
        return res.status(500).json({ error: "Erro interno ao verificar badge" });
    }
});
app.post('/validateBadgeLocal', async (req, res) => {
    const { badgeId, descHash, proof_nodes, proof_indices } = req.body;
    // Validações básicas de input
    if (typeof badgeId !== 'number' ||
        typeof descHash !== 'string' ||
        !Array.isArray(proof_nodes) ||
        !Array.isArray(proof_indices) ||
        proof_nodes.length !== proof_indices.length) {
        return res.status(400).json({ valid: false, error: 'Parâmetros inválidos' });
    }
    try {
        // 1) Inicializa Poseidon
        const poseidon = await (0, circomlibjs_1.buildPoseidon)();
        const F = poseidon.F;
        // Função auxiliar para calorar hash de 2 inputs
        function poseidonHash(a, b) {
            const h = poseidon([F.e(a), F.e(b)]);
            return F.toObject(h);
        }
        // 2) Começa com a leaf = Poseidon(badgeId, descHash)
        let node = poseidonHash(BigInt(badgeId), BigInt(descHash));
        // 3) Sobe na Merkle Tree
        for (let i = 0; i < proof_nodes.length; i++) {
            const sibling = BigInt(proof_nodes[i]);
            if (proof_indices[i] === 1) {
                // nosso node foi o filho direito
                node = poseidonHash(sibling, node);
            }
            else {
                // nosso node foi o filho esquerdo
                node = poseidonHash(node, sibling);
            }
        }
        // 4) Checa se bate com a root
        const valid = node === ROOT;
        return res.json({ valid });
    }
    catch (err) {
        console.error("Erro ao verificar badge:", err);
        return res.status(500).json({ valid: false, error: 'Erro interno' });
    }
});
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Whispr ZK API running on port ${PORT}`);
});
