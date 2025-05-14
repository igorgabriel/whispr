import { Router } from "express";
import { generateHash } from "./zk.js";
import { buildTreeAndGetRoot } from "./merkle.js";

export const routes = Router();

routes.post("/hash", async (req, res) => {
  const { badgeId } = req.body;
  if (!badgeId) return res.status(400).json({ error: "badgeId is required" });

  const hash = await generateHash(badgeId);
  res.json({ hash });
});

routes.get("/merkle-root", async (_, res) => {
  const root = await buildTreeAndGetRoot();
  res.json({ root });
});
