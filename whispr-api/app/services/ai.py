import os
import httpx
from dotenv import load_dotenv
from app.models.schema import Language, Emotion
from app.utils.constants import CONFESSION_PROMPT, RISK_PROMPT, EMOTION_PROMPT

load_dotenv()

OPENAI_API_KEY = os.getenv("OPENAI_API_KEY")
OPENAI_API_URL = os.getenv("OPENAI_API_URL")

HEADERS = {
    "Content-Type": "application/json",
    "Authorization": f"Bearer {OPENAI_API_KEY}"
}
MODEL = os.getenv("OPENAI_API_MODEL")

async def get_ai_response(message: str, language: str = Language.PT, risk: bool = False) -> str:
    system_prompt = (CONFESSION_PROMPT[language]) + (" " + RISK_PROMPT[language] if risk else "")
    print(system_prompt)
    body = {
        "model": MODEL,
        "messages": [
            {"role": "system", "content": system_prompt},
            {"role": "user", "content": message}
        ],
        "temperature": 0.85,
    }
    async with httpx.AsyncClient() as client:
        response = await client.post(OPENAI_API_URL, headers=HEADERS, json=body)
        response.raise_for_status()
        return response.json()["choices"][0]["message"]["content"]

async def get_emotion_from_text(text: str, language: str = Language.PT) -> str:
    system_prompt = EMOTION_PROMPT[language]
    body = {
        "model": MODEL,
        "messages": [{"role": "system", "content": system_prompt},
                    {"role": "user", "content": text}],
        "temperature": 0.0
    }

    async with httpx.AsyncClient() as client:
        response = await client.post(OPENAI_API_URL, headers=HEADERS, json=body)
        response.raise_for_status()
        return response.json()["choices"][0]["message"]["content"].strip().lower()
