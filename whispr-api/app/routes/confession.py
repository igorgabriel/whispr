from fastapi import APIRouter, Query
from app.models.confession_schema import Confession, ConfessionList, ConfessionRequest, ConfessionResponse
from app.models.schema import Emotion, Language
from app.utils.constants import RISK_WORDS
from datetime import datetime, timedelta

router = APIRouter()

@router.post(
    "", 
    response_model=ConfessionResponse,
    summary="Receive user's emotional confession",
    tags=["Confession"],
    description="""
Accepts a text input written by the user, expressing their emotional state, in either English or Portuguese.  
The API analyzes the text, detects potential emotional risk based on predefined keywords,  
and returns a simulated empathetic response, the predominant emotion, and whether a risk flag was triggered.

- If `risk=true`, the response is more protective and supportive and a zk-proof of safe moderation is included.
- `emotion` is symbolic and mock-generated.
- `language` must be either `"en"` or `"pt"`.
"""
)
def handle_confession(data: ConfessionRequest):
    text = data.text.lower()
    lang = data.language.value

    risk = any(word in text for word in RISK_WORDS[lang])

    if lang == Language.PT:
        reply = (
            "Sinto muito que você esteja se sentindo assim. Estou aqui com você."
            if risk else "Obrigado por confiar em mim. Você pode desabafar sempre que quiser."
        )
    else:
        reply = (
            "I'm really sorry you're feeling this way. I'm here with you."
            if risk else "Thank you for trusting me. You can always share your thoughts here."
        )

    # Mock emotion detection
    emotion = Emotion.SADNESS if risk else Emotion.CALM
    
    zk_proof = None
    if risk:
        zk_proof = f"zk-proof-mod-safe-{text[:6].replace(' ', '')}"

    return ConfessionResponse(reply=reply, emotion=emotion, risk=risk, zk_moderation_proof=zk_proof)

@router.get(
    "",
    response_model=ConfessionList,
    summary="Get past AI interactions",
    description="Returns a mock list of user's previous confessions and AI responses.",
    tags=["Confession"]
)
def get_history(user_id: str = Query(..., description="Anonymous user ID")):
    # Mock data
    mock_items = [
        Confession(
            message="Sinto que não sou bom o suficiente.",
            reply="Validação emocional e incentivo à autocompaixão.",
            emotion=Emotion.SADNESS,
            timestamp=datetime.now() - timedelta(days=2)
        ),
        Confession(
            message="Hoje eu consegui sair da cama e caminhar.",
            reply="Reforço positivo e reconhecimento do esforço.",
            emotion="alegria",
            timestamp=datetime.now() - timedelta(days=1)
        )
    ]
    return ConfessionList(user_id=user_id, history=mock_items)
