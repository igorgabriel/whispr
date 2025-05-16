import { zkVerifySession } from "zkverifyjs";
import { ethers } from "ethers";
import * as fs from "fs";
import * as dotenv from "dotenv";
import { UltraPlonkBackend } from "@aztec/bb.js";
import { Noir } from "@noir-lang/noir_js";
dotenv.config();

async function registerVK() {
  // 1) Configuracao inicial
  console.log("Configurando sessão...")
  const res = await fetch("./circuits.json");
  const circuit = await res.json();

  const noir = new Noir(circuit);
  const backend = new UltraPlonkBackend(circuit.bytecode);
  console.log("Sessão configurada... ✅");

  const mnemonic = process.env.MNEMONIC || "test";

//   // 2) Cria a sessão na rede Volta
//   const session = await zkVerifySession.start().Volta().withAccount(mnemonic);

//   // 3) Carrega a verification key (zkey) gerada pelo nargo/barretenberg
//   const vk = fs.readFileSync("target/badge_membership.zkey");

//   // 4) Registra no zkVerify
//   const { transactionResult } = await session
//     .registerVerificationKey()
//     .ultraplonk()
//     .execute(vk);

//   const receipt = await transactionResult.waitForSuccess();
//   console.log("🟢 VK registrado! statementHash =", receipt.statementHash);
}

registerVK().catch(console.error);
