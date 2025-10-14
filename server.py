from fastapi import FastAPI, UploadFile, Form
from pydantic import BaseModel
import uvicorn
import os

app = FastAPI()

class TalkRequest(BaseModel):
    image_url: str
    audio_url: str

@app.post("/generate")
async def generate(req: TalkRequest):
    # 假裝呼叫 SadTalker 主程式
    result_path = "/app/output/demo.mp4"
    return {"status": "ok", "video_path": result_path}

@app.get("/")
def health():
    return {"status": "running"}

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)
