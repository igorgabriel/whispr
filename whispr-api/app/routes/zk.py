import hashlib
from fastapi import APIRouter

from app.models.zk_schema import ZkBadgeRequest, ZkBadgeResponse, ZkUnicityRequest, ZkUnicityResponse

router = APIRouter()

@router.post(
    "/unicity",
    response_model=ZkUnicityResponse,
    summary="Generate zk-proof of uniqueness from wallet",
     tags=["ZK Proof"],
    description="""
Validates wallet signature and generates a mock zk-proof that 
represents a unique user.
"""
)
def generate_unicity_proof(data: ZkUnicityRequest):
    # ⚠️ Mock signature validation
    if not data.signed_nonce.startswith("0x") or len(data.signed_nonce) < 10:
        return ZkUnicityResponse(user_id="", zk_proof="", verified=False)

    # Gera um identificador anônimo
    hashed_id = hashlib.sha256(data.wallet_address.lower().encode()).hexdigest()[:10]
    user_id = f"anon-{hashed_id}"

    # Mock da prova de unicidade (normalmente uma zk-proof real)
    zk_proof = f"zk-proof-unicity-{hashed_id[-6:]}"

    return ZkUnicityResponse(
        user_id=user_id,
        zk_proof=zk_proof,
        verified=True
    )
    
@router.post(
    "/badges",
    response_model=ZkBadgeResponse,
    summary="Generate zk-based usage badges",
    tags=["ZK Proof"],
    description="""
Validates a user's zk-proof of uniqueness and returns the list of earned emotional resilience badges.  
The response includes a mock zk-proof representing the awarded badges, enabling privacy-preserving achievements.
"""
)
def generate_badges(data: ZkBadgeRequest):
    if not data.unicity_proof.startswith("zk-proof-"):
        return ZkBadgeResponse(
            badges=[],
            verified=False,
            zk_proof=""
        )

    earned_badges = ["3-day-reflection", "10-journal-entries"]
    zk_proof = f"zk-proof-{''.join([b[0] for b in earned_badges])}"

    return ZkBadgeResponse(
        badges=earned_badges,
        verified=True,
        zk_proof=zk_proof
    )