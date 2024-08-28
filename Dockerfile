FROM nvcr.io/nvidia/l4t-pytorch:r35.2.1-pth2.0-py3

WORKDIR /app

COPY src/requirements.txt .
RUN pip install -r requirements.txt

COPY src/detect.py .

CMD ["python", "detect.py"]