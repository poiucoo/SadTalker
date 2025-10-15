# 使用 PyTorch 官方 CUDA Runtime 基底映像
FROM pytorch/pytorch:2.1.0-cuda12.1-cudnn8-runtime

# 設定工作目錄
WORKDIR /app

# ⚙️ 避免 tzdata 在安裝時要求互動輸入
ENV DEBIAN_FRONTEND=noninteractive

# 安裝系統依賴（修正 libxrender/libgl 問題 + 增加 runtime 安全依賴）
RUN apt-get update && apt-get install -y \
    git \
    ffmpeg \
    libsm6 \
    libxext6 \
    libxrender1 \
    libgl1-mesa-glx \
    libglib2.0-0 \
    build-essential \
    python3-dev \
 && rm -rf /var/lib/apt/lists/*

# 🧩 複製 requirements.txt 並安裝 Python 依賴
COPY requirements.txt .
RUN pip install --upgrade pip setuptools wheel && \
    pip install --no-cache-dir -r requirements.txt && \
    pip cache purge

# 🔍 顯示 PyTorch CUDA 版本（確認 CUDA 相容）
RUN python -c "import torch; print('✅ Torch version:', torch.__version__); print('✅ CUDA version:', torch.version.cuda)"

# 📁 複製所有程式碼進入容器
COPY . .

# 🌐 開啟伺服器端口 (RunPod Serverless 通常使用 8000)
EXPOSE 8000

# 🕓 增加映像推送與執行逾時時間
ENV DOCKER_UPLOAD_TIMEOUT=900
ENV PYTHONUNBUFFERED=1

# 🚀 啟動主伺服器
CMD ["python", "server.py"]
