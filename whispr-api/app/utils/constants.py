

from app.models.schema import Language

RISK_WORDS = {
    Language.PT: [
        "suicídio", "morrer", "matar", "sumir", "me cortar", "acabar com tudo", "tirar minha vida"
    ],
    Language.EN: [
        "suicide", "kill myself", "disappear", "die", "hurt myself", "end it all", "take my life"
    ]
}