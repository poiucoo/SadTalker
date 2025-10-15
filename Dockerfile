# 使用 PyTorch 官方 CUDA Runtime 基底映像
FROM pytorch/pytorch:2.1.0-cuda12.1-cudnn8-runtime

# 設定工作目錄
WORKDIR /app

# ⚙️ 避免 tzdata 在安裝時要求互動輸入
ENV DEBIAN_FRONTEND=noninteractive

# 安裝系統依賴
# 新增 build-essential 與 python3-dev 以修正 numba 編譯錯誤
RUN apt-get update && apt-get install -y \
    git \
    ffmpeg \
    libsm6 \
    libxext6 \
    libxrender-dev \
    libgl1 \
    build-essential \
    python3-dev \
 && rm -rf /var/lib/apt/lists/*

# 🧩 複製 requirements.txt 並安裝 Python 依賴
COPY requirements.txt .
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# 📁 複製所有程式碼進入容器
COPY . .

# 🌐 開啟伺服器端口 (RunPod Serverless 通常使用 8000)
EXPOSE 8000

# 🕓 增加映像推送超時時間（避免 build 時 registry timeout）
ENV DOCKER_UPLOAD_TIMEOUT=600

# 🚀 啟動主伺服器
CMD ["python", "server.py"]
