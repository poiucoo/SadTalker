from runpod import serverless
from fastapi import FastAPI
import uvicorn

app = FastAPI()

@app.get("/")
def root():
    return {"status": "running"}

def handler(event):
    """
    This function is required by RunPod.
    It will be invoked when a serverless job runs.
    """
    return {"message": "SadTalker API handler is active.", "event": event}

# Tell RunPod which function is the entrypoint
if __name__ == "__main__":
    # local run
    uvicorn.run(app, host="0.0.0.0", port=8000)

# RunPod entry
serverless.start({"handler": handler})
