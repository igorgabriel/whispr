from datetime import datetime
from pydantic import BaseModel
from typing import List, Optional

from app.models.schema import Emotion, Language

class ConfessionRequest(BaseModel):
    text: str
    language: Language

class ConfessionResponse(BaseModel):
    reply: str
    emotion: Emotion
    risk: bool
    zk_moderation_proof: Optional[str] = None
    
class Confession(ConfessionResponse):
    message: str
    timestamp: datetime
    
class ConfessionList(BaseModel):
    user_id: str
    confessions: List[Confession]