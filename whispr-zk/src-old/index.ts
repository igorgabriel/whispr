import express from "express";
import { routes } from "./routes.js";

const app = express();
app.use(express.json());
app.use("/api", routes);

const PORT = process.env.PORT || 5001;
app.listen(PORT, () => {
  console.log(`Whispr ZK API running on port ${PORT}`);
});
