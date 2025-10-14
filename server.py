import runpod
from fastapi import FastAPI
import uvicorn

app = FastAPI()

@app.get("/")
def root():
    return {"status": "running"}

def handler(event):
    """
    Required by RunPod
    """
    input_data = event.get("input", {})
    # 這裡先用簡單輸出測試，確保 handler 有執行
    result = {"echo": input_data, "message": "SadTalker API handler is working"}
    return result

# ✅ RunPod entry（一定要在最外層）
runpod.serverless.start({"handler": handler})
