# 🟣 Whispr – Diário emocional com IA + zkVerify

Este repositório contém o backend, o app mobile e os scripts de integração ZK do projeto **Whispr**, um diário emocional assistido por inteligência artificial, com foco em privacidade, empatia e provas de identidade anônima.

---

## 🚀 Sobre o projeto

**Whispr** é um app de bem-estar emocional que permite que o usuário desabafe com segurança e anonimato. A IA responde com escuta ativa, empatia e profundidade emocional, sem julgamentos ou conselhos clichês. O app também utiliza **zkVerify** para gerar provas de:

- Moderação segura
- Conquistas (badges) de uso

---

## 🎯 Este projeto está sendo desenvolvido como parte do **Hackathon da NearX**

O MVP inclui:
- Login com carteira Web3 (Talisman)
- Tela de desabafo com resposta da IA
- Detecção de modo crítico em caso de risco emocional
- Tela de conquistas com provas ZK (sem revelar qual badge foi obtida)

---

## Estrutura do projeto
```
whispr/
├── whispr-api/             # Backend FastAPI com rotas e serviços
├── mobile/          # App Flutter (input, resposta, badges)
├── whispr-zk/              # Serviço REST Node.js com zkVerify
├── shared/          # Enums (Emotion), constantes, utils
└── project-board/   # Documentos: escopo, arquitetura, prompts
```

### Rodar o projeto

Na raiz do projeto, execute o seguinte comando:
```
docker compose up
```

### App mobile
```
cd mobile
flutter run
```