import { buildPoseidon } from "circomlibjs";
import { utils } from "ffjavascript";

export async function generateHash(badgeId: string): Promise<string> {
  const poseidon = await buildPoseidon();
  const prefix = "whispr_badge:";
  const input = Buffer.from(prefix + badgeId, "utf8");

  const chunk1 = input.subarray(0, 16);
  const chunk2 = input.subarray(16, 32);

  const f1 = utils.leBuff2int(chunk1);
  const f2 = utils.leBuff2int(chunk2);

  const hash = poseidon([f1, f2]);
  return hash.toString();
}
