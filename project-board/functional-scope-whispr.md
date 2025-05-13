# 📘 Escopo Funcional – Whispr MVP com zkVerify

Este documento define com clareza as funcionalidades do MVP do Whispr, incluindo suporte emocional com IA, diário pessoal, rastreamento emocional e integração com provas de conhecimento zero (zkVerify). Período de entrega: 18 dias (~72h).

---

## ✅ Funcionalidades principais do MVP

1. **Entrada de desabafo com resposta da IA**
   - Campo de texto livre
   - IA responde com empatia usando prompt customizado
   - Detecção de risco emocional (modo crítico)

2. **Diário pessoal**
   - Usuário escreve sem retorno da IA
   - Entradas ficam salvas localmente ou em nuvem
   - Emoção predominante é detectada e rotulada com ícone da Whispy

3. **Histórico de desabafos**
   - Lista com desabafos e respostas anteriores
   - Emoções predominantes identificadas
   - Visual simples com data e ícone emocional

4. **Resumo emocional (Aba Emoções)**
   - Gráfico com variação de emoções
   - Emoções mais frequentes
   - Mini calendário emocional
   - Frase de insight leve

5. **Aba Whispy**
   - Mensagem simbólica e acolhedora
   - Identidade anônima com zkVerify
   - Exibição de conquistas (ZK-badges)
   - Configurações básicas: idioma, tema, apagar local

6. **Tela de segurança (modo crítico)**
   - Ativada quando IA detecta risco emocional
   - Mensagem firme e acolhedora
   - Botão para ajuda real: CVV, chat ou pessoa confiável

---

## 🔐 Funcionalidades zkVerify

- **Prova de unicidade**: assegura que cada usuário é único, sem identificação
- **ZK-badges**: recompensa por constância emocional (ex: 3 dias de uso)
- **Prova de moderação segura**: garante que todo texto passa por IA com filtro emocional

---

## 🚫 Fora do escopo do MVP

- Entrada por voz
- Interação entre usuários
- Memória contínua de contexto
- Notificações push
- Login com e-mail/senha

---

## 🧱 MVP completo =

- IA funcional e segura
- Diário pessoal com emoção detectada
- Análise emocional no tempo (tela Emoções)
- Identidade ZK validada + conquistas
- 9 telas funcionais implementadas em Flutter
