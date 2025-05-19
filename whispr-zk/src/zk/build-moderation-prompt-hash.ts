import { buildPoseidon } from "circomlibjs";
import { toUtf8Bytes } from "ethers";
import prompt from "./moderation-prompt";

async function hashPrompt(prompt: string): Promise<string> {
  // 1) Inicializa o Poseidon
  const poseidon = await buildPoseidon();
  const F = poseidon.F;

  // 2) Converte pra bytes UTF-8
  const bytes = toUtf8Bytes(prompt);

  // 3) Itera byte a byte, acumulando um hash_2
  //    Usamos F.e(...) para criar Fields a partir de BigInt
  let state = F.e(BigInt(0));
  for (const b of bytes) {
    const byteField = F.e(BigInt(b));
    state = poseidon([state, byteField]);
  }

  // 4) Extrai o valor de campo para BigInt e retorna decimal
  const out = F.toObject(state) as bigint;
  return out.toString();
}

// Exemplo de uso:
(async () => {
  const promptHash = await hashPrompt(prompt);
  console.log("promptHash =", promptHash);
})();
