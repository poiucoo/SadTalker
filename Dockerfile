# ✅ 使用 PyTorch 官方 CUDA Runtime 基底
FROM pytorch/pytorch:2.1.0-cuda12.1-cudnn8-runtime

# 設定工作目錄
WORKDIR /app

# ✅ 安裝系統依賴
# 這些套件是 SadTalker、facexlib、gfpgan、opencv 需要的
RUN apt-get update && apt-get install -y \
    git \
    ffmpeg \
    libsm6 \
    libxext6 \
    libxrender-dev \
    libgl1 \
    && rm -rf /var/lib/apt/lists/*

# ✅ 複製 requirements.txt 並安裝 Python 依賴
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# ✅ 複製所有程式碼進入容器
COPY . .

# ✅ 暴露埠口（RunPod Serverless 通常使用 8000）
EXPOSE 8000

# ✅ 啟動主伺服器
CMD ["python", "server.py"]
