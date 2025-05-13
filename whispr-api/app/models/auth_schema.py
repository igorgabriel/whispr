from pydantic import BaseModel

class NonceResponse(BaseModel):
   nonce: str
   
class LoginRequest(BaseModel):
    wallet_address: str
    signed_nonce: str
    original_nonce: str

class LoginResponse(BaseModel):
    user_id: str
    access_token: str
    authenticated: bool