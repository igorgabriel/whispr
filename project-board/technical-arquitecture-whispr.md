# 🧱 Arquitetura Técnica – Whispr MVP (com zkVerify)

Este documento descreve detalhadamente a arquitetura técnica do Whispr, contemplando a estrutura do backend, mobile, integração com IA e zkVerify, banco de dados e fluxo de dados completo do MVP.

---

## 🧭 Visão Geral da Arquitetura

```
User (Flutter App)
     ↓
Input de desabafo
     ↓
API (FastAPI)
     ├── IA (OpenAI)
     ├── Moderação de risco (palavras-chave)
     ├── Geração de provas ZK (zkVerify)
     └── Banco de dados (Firebase Firestore)
             ↓
        Retorna: resposta da IA + status emocional + proof ZK
     ↓
Flutter exibe resposta e salva histórico local
```

---

## 📱 Mobile (Flutter)

Responsável por:

- Input do desabafo
- Visualização da resposta da IA
- Histórico local (e opcional online)
- Registro de entradas no diário pessoal
- Histórico de desabafos e diário
- Aba Emoções com análise visual de sentimentos
- Aba Whispy com identidade ZK, badges e configurações
- Geração inicial de identidade única ZK (token)
- Escolha ou detecção de idioma do usuário

Linguagem: Dart  
Armazenamento local: SharedPreferences ou SQLite (opcional)

---

## ⚙️ Backend (FastAPI – Python)

Responsável por:

- Receber desabafo do usuário
- Aplicar moderação e análise de risco
- Gerar resposta com IA (OpenAI)
- Gerar e/ou verificar provas com zkVerify
- Armazenar resultado no Firestore
- Servir dados via REST

Principais tecnologias:
- `fastapi`
- `pydantic`
- `httpx` (para chamadas assíncronas à OpenAI)
- `firebase-admin` (para integração com o Firestore)

---

## 🔐 zkVerify (camada ZK)

Responsável por:

- Gerar prova de que o usuário é único (sem identidade revelada)
- Criar prova de que a moderação foi aplicada
- Gerar ZK-badges (ex: constância de uso, dias de desabafo)

Tecnologias:
- `zkVerify.js` (Node.js SDK)
- Scripts separados em `/zk/`
- Pode rodar localmente ou em container isolado

Integração com Python via:
- subprocess (`subprocess.run(...)`)
- ou serviço local REST

---

## 🗂️ Estrutura de Pastas

```
whispr/
├── api/                  # Backend FastAPI
│   ├── main.py
│   ├── routes/
│   │   ├── desabafo.py
│   │   └── zk.py
│   ├── services/
│   │   ├── ia.py
│   │   ├── mod.py
│   │   └── zk_bridge.py
│   └── models/
│       └── schema.py
│
├── mobile/               # Flutter app
│   └── lib/
│       ├── screens/
│       ├── services/
│       └── widgets/
│
├── zk/                   # Scripts e arquivos ZK
│   ├── generate_proof.js
│   ├── verify_proof.js
│   └── circuits/
│
├── shared/               # Tipos e constantes comuns
│   └── emotions.py
│
└── project-board/        # Planejamento e documentação
    ├── arquitetura.md
    ├── escopo.md
    └── prompts.md
```

---

## 🧩 Endpoints da API

| Método | Rota              | Descrição                                                       |
|--------|-------------------|------------------------------------------------------------------|
| POST   | `/desabafo`       | Envia texto e recebe resposta da IA + prova de moderação        |
| GET    | `/historico`      | Retorna histórico de desabafos do usuário                       |
| POST   | `/zk/unicidade`   | Gera uma zk-proof de que o usuário é único                      |
| POST   | `/zk/badge`       | Gera uma zk-proof de conquista emocional (ex: 3 dias seguidos)  |

---

## 🔐 Banco de Dados – Firestore (via Firebase)

- Usado para persistir:
  - Histórico de desabafos (texto, data, emoção, resposta)
  - Provas geradas (opcional, ou hash da proof)
  - Informações anônimas de uso (eventualmente)

- Justificativa:
  - Escalável, fácil de usar, com SDK pronto para Python e Flutter
  - Dispensa setup de infraestrutura pesada para o MVP

---

## 🔁 Fluxo de dados resumido

1. Usuário envia um desabafo pelo app (Flutter)
2. API recebe o texto e faz análise de risco
3. Se seguro, envia à IA para gerar resposta
4. Gera uma prova ZK de que foi moderado
5. Armazena histórico no Firestore
6. Retorna ao app: resposta, emoção detectada e proof opcional

---

## ✅ MVP será considerado completo quando:

- API, IA e moderação estiverem 100% funcionais
- Proof ZK de unicidade e 1 badge funcional existirem
- Usuário conseguir desabafar, ver resposta, e acompanhar histórico com confiança
