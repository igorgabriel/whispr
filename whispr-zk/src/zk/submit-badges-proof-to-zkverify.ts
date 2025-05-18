import { ZkVerifyEvents, zkVerifySession } from "zkverifyjs";
import dotenv from "dotenv";
import path from "path";
import fs from "fs";

dotenv.config();

async function main() {
  // Initialize zkVerify session
  console.log("Setting up zkVerify session... ⏳");

  const session = await zkVerifySession
    .start()
    .Volta()
    .withAccount(process.env.MNEMONIC!);
  console.log("Session setup complete... ✅");

  // Ler proof.bin e public.json
  const proofPath = path.resolve(__dirname, "../../circuits/badges/target/proof.bin");
  const publicJsonPath = path.resolve(
    __dirname,
    "../../circuits/badges/target/public.json"
  );

  const proof = fs.readFileSync(proofPath);
  const publicSignals = JSON.parse(
    fs.readFileSync(publicJsonPath, "utf8")
  ) as string[];

  const vkHex = fs
    .readFileSync(
      path.resolve(__dirname, "../../circuits/badges/target/vk.hex"),
      "utf8"
    )
    .trim();
  console.log("VK Hex:", vkHex);
  // 4) registrar a VK (UltraPlonk)
  console.log("⏳ Registrando VK…");
  const { transactionResult: vkTx } = await session
    .registerVerificationKey()
    .ultraplonk()
    .execute(vkHex);
  const vkReceipt = await vkTx;
  console.log("🟢 VK registrado:", vkReceipt.statementHash);

  // 5) submeter a prova usando esse mesmo vkHex
  console.log("⏳ Submetendo prova…");
  const { events, transactionResult } = await session
    .verify()
    .ultraplonk()
    .withRegisteredVk()
    .execute({
      proofData: { vk: vkHex, proof, publicSignals },
      domainId: 0,
    });

  events.on(ZkVerifyEvents.IncludedInBlock, (e) =>
    console.log("IncludedInBlock:", e.statement)
  );
  events.on(ZkVerifyEvents.Finalized, (e) => console.log("Finalized:", e));

  const receipt = await transactionResult;
  console.log("   Tx hash:", receipt.txHash);
  console.log("   Domain ID     :", receipt.domainId);
  console.log("   Block hash    :", receipt.blockHash);
  console.log("   StatementHash :", receipt.statement);
  console.log("   Aggregation ID:", receipt.aggregationId);
  console.log("   Status        :", receipt.status);
  console.log("✅ Prova verificada on-chain — txHash:", receipt.txHash);
  process.exit(0);

  // // Submeter a prova Ultra-Plonk
  // console.log("⏳ Submetendo prova ao zkVerify...");
  // const { events, transactionResult } = await session
  //   .verify()
  //   .ultraplonk()
  //   .withRegisteredVk() // usa o vk que você registrou previamente
  //   .execute({
  //     proofData: {
  //       vk, // hash do vk registrado
  //       proof, // Uint8Array do proof.bin
  //       publicSignals, // []
  //     },
  //     domainId: 0,
  //   });

  // events.on(ZkVerifyEvents.IncludedInBlock, (e) =>
  //   console.log(`Proof included in block: ${e.statement}`)
  // );
  // events.on(ZkVerifyEvents.Finalized, (e) =>
  //   console.log(`Proof finalized: ${JSON.stringify(e)}`)
  // );
  // events.on(ZkVerifyEvents.NewAggregationReceipt, (e) =>
  //   console.log(`Aggregation complete: ${JSON.stringify(e)}`)
  // );

  // // Aguardar confirmação on-chain
  // const receipt = await transactionResult;
  // console.log("✅ Prova verificada on-chain!");
  // console.log("Receipt completo: ", receipt);
  // console.log("   Tx hash:", receipt.txHash);
  // console.log("   Domain ID     :", receipt.domainId);
  // console.log("   Block hash    :", receipt.blockHash);
  // console.log("   StatementHash :", receipt.statement);
  // console.log("   Aggregation ID:", receipt.aggregationId);
  // console.log("   Status        :", receipt.status);

  process.exit(0);
}
main().catch((err) => {
  console.error(err);
  process.exit(1);
});
