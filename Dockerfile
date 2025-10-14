FROM pytorch/pytorch:2.1.0-cuda12.1-cudnn8-devel

WORKDIR /app

# 基礎依賴
RUN apt-get update && apt-get install -y \
    git ffmpeg libsm6 libxext6 libgl1-mesa-glx

# 安裝 Python 套件
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# 複製所有檔案
COPY . .

EXPOSE 8000

CMD ["python", "server.py"]
