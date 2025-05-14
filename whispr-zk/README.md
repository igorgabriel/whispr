# Whispr ZK

Este microserviço é responsável por:

- ✅ Gerar hashes das badges com Poseidon
- ✅ Construir a Merkle Tree de badges
- 🔐 Gerar provas ZK com Noir + UltraPlonk
- 📤 Submeter provas ao zkVerify
- 🌐 Servir endpoints REST para integração com o backend Python do Whispr

---

## 📦 Endpoints disponíveis

### POST `/api/hash`
Gera um hash Poseidon para um `badgeId`.

**Requisição:**
```json
{ "badgeId": "first_confession" }
```

**Resposta:**
```json
{ "hash": "123456789..." }
```

---

### GET `/api/merkle-root`
Retorna a Merkle root atual da árvore construída com as badges válidas.

**Resposta:**
```json
{ "root": "0xabc123..." }
```

---

## ⚙️ Como rodar o projeto

```bash
npm install
npm run dev
```

---

## 📂 Estrutura de Pastas

```
whispr-zk/
├── circuits/             # Circuitos Noir (.nr)
├── inputs/               # Inputs JSON para provas
├── outputs/              # Saídas (proofs, keys)
├── src/
│   ├── index.ts          # Entrada do servidor Express
│   ├── routes.ts         # Rotas da API
│   ├── zk.ts             # Hash Poseidon
│   └── merkle.ts         # Construção da Merkle Tree
├── package.json
├── tsconfig.json
└── README.md             # Este arquivo
```

---

## 🔮 Próximos passos

- Criar o circuito `merkle_badge.nr` com verificação Merkle
- Gerar e validar provas zk-SNARK usando Noir + UltraPlonk
- Adicionar endpoint `/generate-proof` e `/verify-proof`
- Automatizar integração com zkVerify

---

## 🧠 Conceitos usados

- **Poseidon Hash**: hash eficiente para provas ZK
- **Merkle Tree**: estrutura para provar inclusão de dados
- **Zero-Knowledge Proofs**: prova de conhecimento sem revelar o conteúdo
- **Noir + Barretenberg**: ecossistema de circuitos ZK com suporte ao zkVerify