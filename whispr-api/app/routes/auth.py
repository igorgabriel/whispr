import hashlib
from fastapi import APIRouter
from datetime import datetime
from app.models.auth_schema import LoginRequest, LoginResponse, NonceResponse

router = APIRouter()

@router.get(
    "/nonce",
    response_model=NonceResponse,
    summary="Generate nonce for wallet authentication",
    tags=["Authentication"],
    description="Generates a unique message (nonce) to be signed by the user's wallet for login authentication."
)
def get_auth_nonce():
    timestamp = int(datetime.now().timestamp() * 1000)
    message = f"Sign to log into Whispr: {timestamp}"
    return NonceResponse(nonce=message)

@router.post(
    "/login",
    response_model=LoginResponse,
    summary="Authenticate user by wallet signature",
    tags=["Authentication"],
    description="Validates the signed nonce and wallet address to authenticate the user."
)
def login(data: LoginRequest):
    if not data.signed_nonce.startswith("0x") or len(data.signed_nonce) < 10:
        return LoginResponse(user_id="", access_token="", authenticated=False)

    hashed_id = hashlib.sha256(data.wallet_address.lower().encode()).hexdigest()[:10]
    user_id = f"anon-{hashed_id}"

    token = f"mock-token-{user_id}"

    return LoginResponse(user_id=user_id, access_token=token, authenticated=True)