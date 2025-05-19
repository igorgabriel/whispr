import express, { Request, Response } from "express";
import axios from "axios";
import dotenv from "dotenv";
import { ApiPromise, WsProvider } from "@polkadot/api";
import { cryptoWaitReady } from "@polkadot/util-crypto";
import { buildPoseidon } from 'circomlibjs';

dotenv.config();
const app = express();
app.use(express.json());

// Types for badge validation request/response
interface ValidateBadgeRequest {
  statementHash: string;
}
interface ValidateBadgeResponse {
  valid: boolean;
}
interface ErrorResponse {
  error: string;
}

const ROOT = BigInt(process.env.ROOT || '123');

// Polkadot API singleton
let api: ApiPromise;
async function getApi(): Promise<ApiPromise> {
  if (!api) {
    await cryptoWaitReady();
    const wsUrl = process.env.ZKVERIFY_WS_URL;
    if (!wsUrl) throw new Error("ZKVERIFY_WS_URL não definido no .env");
    const provider = new WsProvider(wsUrl);
    api = await ApiPromise.create({ provider });
  }
  return api;
}

// Função para verificar se o statementHash foi verificado on-chain
async function isProofVerified(statementHash: string): Promise<boolean> {
  const api = await getApi();
  const state = await api.query.settlementUltraplonkPallet.statementStates(
    statementHash
  );
  // Ajuste conforme o enum do pallet
  // O state é um enum; converta para string/JSON e compare
  const result = state.toString();
  return result === "Verified";
}

// Rota para validar badge
// @ts-ignore
app.post("/validateBadge", async (req: Request,res: Response) => {
    const { statementHash } = req.body;
    if (typeof statementHash !== "string") {
      return res
        .status(400)
        .json({ error: "statementHash deve ser uma string" });
    }
    try {
      const valid = await isProofVerified(statementHash);
      return res.json({ valid });
    } catch (err) {
      console.error("Erro ao verificar badge:", err);
      return res.status(500).json({ error: "Erro interno ao verificar badge" });
    }
  }
);

// @ts-ignore
app.post('/validateBadgeLocal', async (req: Request, res: Response) => {
  const { badgeId, descHash, proof_nodes, proof_indices } = req.body as {
    badgeId: number;
    descHash: string;
    proof_nodes: string[];
    proof_indices: number[];
  };

  // Validações básicas de input
  if (
    typeof badgeId !== 'number' ||
    typeof descHash !== 'string' ||
    !Array.isArray(proof_nodes) ||
    !Array.isArray(proof_indices) ||
    proof_nodes.length !== proof_indices.length
  ) {
    return res.status(400).json({ valid: false, error: 'Parâmetros inválidos' });
  }

  try {
    // 1) Inicializa Poseidon
    const poseidon = await buildPoseidon();
    const F        = poseidon.F;

    // Função auxiliar para calorar hash de 2 inputs
    function poseidonHash(a: bigint, b: bigint): bigint {
      const h = poseidon([F.e(a), F.e(b)]);
      return F.toObject(h) as bigint;
    }

    // 2) Começa com a leaf = Poseidon(badgeId, descHash)
    let node = poseidonHash(
      BigInt(badgeId),
      BigInt(descHash)
    );

    // 3) Sobe na Merkle Tree
    for (let i = 0; i < proof_nodes.length; i++) {
      const sibling = BigInt(proof_nodes[i]);
      if (proof_indices[i] === 1) {
        // nosso node foi o filho direito
        node = poseidonHash(sibling, node);
      } else {
        // nosso node foi o filho esquerdo
        node = poseidonHash(node, sibling);
      }
    }

    // 4) Checa se bate com a root
    const valid = node === ROOT;
    return res.json({ valid });
  } catch (err) {
    console.error("Erro ao verificar badge:", err);
    return res.status(500).json({ valid: false, error: 'Erro interno' });
  }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Whispr ZK API running on port ${PORT}`);
});
