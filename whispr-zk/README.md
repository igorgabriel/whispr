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

## Badges

| Badge ID | Nome da Badge | Critério de Conquista |
| -------- | ------------- | --------------------- |
| whispr_badge:first_confession |	Primeira Confissão |	Enviou o primeiro desabafo no app |
| whispr_badge:daily_streak_3 |	Três Dias Seguidos |	Usou o app por 3 dias consecutivos |
| whispr_badge:daily_streak_7 |	Sete Dias Seguidos |	Usou o app por 7 dias consecutivos |
| whispr_badge:confess_5	| Desabafou 5 vezes |	Enviou 5 confissões no total |
| whispr_badge:confess_10	| Desabafou 10 vezes |	Enviou 10 confissões no total |
| whispr_badge:night_session |	Confissão Noturna |	Enviou uma confissão entre 0h e 5h |
| whispr_badge:opened_7_days |	Consistência Semanal |	Abriu o app pelo menos 1x em 7 dias diferentes |
| whispr_badge:long_text |	Texto Profundo |	Enviou uma confissão com mais de 300 caracteres |
| whispr_badge:calm_after_risk |	Renasceu Calmo |	Confessou risco e depois teve uma emoção “calma” |
| whispr_badge:early_user |	Usuário Pioneiro |	Usou o app no período de lançamento (beta) |

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


## Comandos para o circuito em noir
Executar os seguintes comandos dentro da pasta **circuits/**:
```
nargo compile
nargo test
nargo execute
bb prove -b ./target/circuits.json -w ./target/circuits.gz -o ./target
bb write_vk -b ./target/circuits.json -o ./target 
```
Executar o seguintes comandos na raiz do projeto (**whispr-zk**)
```
yarn build-merkle
yarn gen-ultraplonk-proof
yarn submit-proof-to-zkverify
```
