# 🚀 Whispr Backend – FastAPI

Este é o backend do projeto **Whispr**, construído com FastAPI e Python.  
Ele será responsável por lidar com os desabafos, análises emocionais, integração com IA e provas ZK (zkVerify).

---

## 📁 Estrutura de diretórios

```
whispr-api/
├── app/
│   ├── main.py
│   ├── routes/
│   ├── services/
│   ├── models/
│   └── utils/
├── venv/                # Ambiente virtual Python
├── requirements.txt
└── README.md
```

---

## ⚙️ Como rodar localmente

### 1. Criar o ambiente virtual

```bash
python -m venv venv
```

### 2. Ativar o ambiente virtual

#### Linux / macOS:
```bash
source venv/bin/activate
```

#### Windows (CMD):
```cmd
venv\Scripts\activate
```

#### Windows (PowerShell):
```powershell
venv\Scripts\Activate.ps1
```

> ⚠️ Se der erro no PowerShell, execute:
> `Set-ExecutionPolicy RemoteSigned` com permissões de administrador

---

### 3. Instalar dependências

```bash
pip install -r requirements.txt
```

Ou, se preferir instalar manualmente:

```bash
pip install fastapi uvicorn httpx pydantic python-dotenv
```

---

### 4. Rodar o servidor

```bash
uvicorn app.main:app --reload
```

Acesse em: [http://localhost:8000](http://localhost:8000)

---

## 📦 Requisitos

- Python 3.10+
- FastAPI
- Uvicorn
- Pydantic
- httpx
- dotenv

---

## 🔐 Integrações futuras

- OpenAI (resposta emocional)
- Firebase (Firestore)
- zkVerify (unicidade e badges)

---

Desenvolvido com 🦉 por Whispr.


---

## 💻 Configurando o ambiente no VS Code

Após criar e ativar o ambiente virtual, siga estes passos para configurar corretamente no VS Code:

### 1. Abrir o projeto no VS Code
No terminal, execute:
```bash
code .
```

### 2. Selecionar o interpretador Python da venv
- Pressione `Ctrl+Shift+P` (ou `Cmd+Shift+P` no macOS)
- Digite: `Python: Select Interpreter`
- Escolha o que aponta para `./venv/bin/python` (ou `./venv/Scripts/python.exe` no Windows)

> Caso não apareça, clique em "Enter interpreter path" e selecione manualmente.

### 3. Ativar terminal com venv
No terminal integrado do VS Code, ative manualmente se necessário:
```bash
source venv/bin/activate
```
Ou no Windows:
```cmd
venv\Scripts\activate
```

### 4. Instalar a extensão Python
Vá em **Extensions** (`Ctrl+Shift+X`), busque por `Python` (Microsoft) e instale.

### 5. Criar configuração persistente (opcional)
Crie o arquivo `.vscode/settings.json` com:

```json
{
  "python.pythonPath": "venv/bin/python"
}
```

No Windows:

```json
{
  "python.pythonPath": "venv\\Scripts\\python.exe"
}
```

---

