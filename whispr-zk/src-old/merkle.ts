import { MerkleTree } from "merkletreejs";
import { buildPoseidon } from "circomlibjs";
import { utils } from "ffjavascript";
import crypto from "crypto";

const BADGES = [
  "first_confession",
  "daily_streak_3",
  "daily_streak_7",
  "confess_5",
  "confess_10",
  "night_session",
  "opened_7_days",
  "long_text",
  "calm_after_risk",
  "early_user",
];

async function hashBadge(badgeId: string) {
  const poseidon = await buildPoseidon();
  const input = Buffer.from(`whispr_badge:${badgeId}`, "utf8");
  const chunk1 = utils.leBuff2int(input.subarray(0, 16));
  const chunk2 = utils.leBuff2int(input.subarray(16, 32));
  return poseidon([chunk1, chunk2]);
}

export async function buildTreeAndGetRoot(): Promise<string> {
  const poseidon = await buildPoseidon();
  const leaves = BADGES.map(hashBadge);
  const tree = new MerkleTree(leaves, poseidon, { sort: true });
  const root = tree.getRoot().toString("hex");
  return `0x${root}`;
}
