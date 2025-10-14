from fastapi import FastAPI
import uvicorn

app = FastAPI()

@app.get("/")
def root():
    return {"status": "running"}

@app.post("/generate")
async def generate():
    # TODO: 呼叫 SadTalker 主程式（這邊先留空）
    return {"status": "ok", "msg": "SadTalker API endpoint running."}

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)
