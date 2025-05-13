from datetime import datetime
from typing import List
from pydantic import BaseModel

from app.models.schema import Emotion, Language

class DiaryRequest(BaseModel):
    text: str
    language: Language

class Diary(BaseModel):
    text: str
    emotion: Emotion
    date: datetime
    
class DiaryList(BaseModel):
    user_id: str
    diaries: List[Diary]