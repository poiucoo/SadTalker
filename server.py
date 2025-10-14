import runpod
from fastapi import FastAPI
import uvicorn

app = FastAPI()

@app.get("/")
def root():
    return {"status": "running"}

# RunPod 的 handler：每次 serverless job 執行時呼叫
def handler(event):
    """
    RunPod serverless handler function.
    Replace this with your own inference logic.
    """
    input_data = event.get("input", {})
    return {
        "message": "SadTalker API handler is active.",
        "input_received": input_data
    }

# 本地測試時使用 uvicorn
if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)

# RunPod serverless 啟動入口
runpod.serverless.start({"handler": handler})
