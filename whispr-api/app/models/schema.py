from enum import Enum

class Language(str, Enum):
    PT = "pt"
    EN = "en"

class Emotion(str, Enum):
    SADNESS = "sadness"
    ANXIETY = "anxiety"
    ANGER = "anger"
    CONFUSION = "confusion"
    CALM = "calm"
    JOY = "joy"
