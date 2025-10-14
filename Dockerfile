FROM pytorch/pytorch:2.1.0-cuda12.1-cudnn8-runtime

# 設定工作目錄
WORKDIR /app

# 安裝系統依賴
RUN apt-get update && apt-get install -y git ffmpeg libsm6 libxext6 && rm -rf /var/lib/apt/lists/*

# 複製 requirements 並安裝套件
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 複製程式碼
COPY . .

# 對外開放 port（本地測試用）
EXPOSE 8000

# 啟動程式
CMD ["python", "-u", "server.py"]
