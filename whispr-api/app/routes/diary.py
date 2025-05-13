from fastapi import APIRouter, Query
from datetime import datetime, timedelta
from app.models.diary_schema import DiaryList, DiaryRequest, Diary
from app.models.schema import Emotion

router = APIRouter()

@router.post(
    "",
    response_model=Diary,
    summary="Receive user's diary entry",
    tags=["Diary"],
    description="""
Accepts a text-only personal diary entry.  
Returns the predominant emotion detected (mocked) and the timestamp.  
No AI response is generated. This is a private emotional record.
"""
)
def handle_diary_entry(data: DiaryRequest):
    text = data.text.lower()
    lang = data.language.value

    # Mock emotion detection
    emotion = Emotion.CALM
    if any(word in text for word in ["angry", "raiva", "furioso", "mad"]):
        emotion = Emotion.ANGER
    elif any(word in text for word in ["triste", "sad", "chorar", "cry"]):
        emotion = Emotion.SADNESS
    elif any(word in text for word in ["ansioso", "preocupado", "nervoso", "anxious"]):
        emotion = Emotion.ANXIETY

    return Diary(emotion=emotion, date=datetime.now())

@router.get(
    "",
    response_model=DiaryList,
    summary="Get user's diary entries",
    tags=["Diary"],
    description="Returns a mock list of diary entries and detected emotions."
)
def get_diary(user_id: str = Query(..., description="Anonymous user ID")):
    mock_entries = [
        Diary(
            text="Hoje foi um dia difícil, pensei em desistir.",
            emotion=Emotion.SADNESS,
            date=datetime.now() - timedelta(days=3)
        ),
        Diary(
            text="Acordei mais leve. Talvez as coisas melhorem.",
            emotion=Emotion.CALM,
            date=datetime.now() - timedelta(days=1)
        )
    ]
    return DiaryList(user_id=user_id, diaries=mock_entries)