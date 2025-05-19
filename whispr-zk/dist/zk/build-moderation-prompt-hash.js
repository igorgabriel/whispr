"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const circomlibjs_1 = require("circomlibjs");
const ethers_1 = require("ethers");
const moderation_prompt_1 = __importDefault(require("./moderation-prompt"));
async function hashPrompt(prompt) {
    // 1) Inicializa o Poseidon
    const poseidon = await (0, circomlibjs_1.buildPoseidon)();
    const F = poseidon.F;
    // 2) Converte pra bytes UTF-8
    const bytes = (0, ethers_1.toUtf8Bytes)(prompt);
    // 3) Itera byte a byte, acumulando um hash_2
    //    Usamos F.e(...) para criar Fields a partir de BigInt
    let state = F.e(BigInt(0));
    for (const b of bytes) {
        const byteField = F.e(BigInt(b));
        state = poseidon([state, byteField]);
    }
    // 4) Extrai o valor de campo para BigInt e retorna decimal
    const out = F.toObject(state);
    return out.toString();
}
// Exemplo de uso:
(async () => {
    const promptHash = await hashPrompt(moderation_prompt_1.default);
    console.log("promptHash =", promptHash);
})();
