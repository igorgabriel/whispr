from fastapi import FastAPI
from app.routes import auth, confession, zk, diary

app = FastAPI()

# Include routes
app.include_router(confession.router, prefix="/confessions")
app.include_router(diary.router, prefix="/diaries")
app.include_router(zk.router, prefix="/zks")
app.include_router(auth.router, prefix="/auths")


@app.get("/")
def root():
    return {"message": "whispr-api backend is running"}
