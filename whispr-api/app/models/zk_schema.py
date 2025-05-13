from pydantic import BaseModel
from typing import List

class ZkUnicityRequest(BaseModel):
    wallet_address: str
    original_nonce: str
    signed_nonce: str
    
class ZkUnicityResponse(BaseModel):
    user_id: str
    zk_proof: str
    verified: bool

class ZkBadgeRequest(BaseModel):
    unicity_proof: str
    
class ZkBadgeResponse(BaseModel):
    badges: List[str]
    zk_proof: str
    verified: bool