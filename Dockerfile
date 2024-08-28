ARG TAG=r36.2.0
FROM nvcr.io/nvidia/l4t-base:${TAG}

# Install any utils needed for execution
RUN apt-get update && apt-get install -y --no-install-recommends \
    sudo \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# Install nvidia-cuda-dev for CUDA developer packages
# Use nvidia-cuda if need CUDA runtime only
RUN apt-get update && apt-get install -y --no-install-recommends \
    nvidia-cuda-dev \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# Install nvidia-opencv-dev for OpenCV developer packages
# Use nvidia-opencv if need OpenCV runtime only
RUN apt-get update && apt-get install -y --no-install-recommends \
    nvidia-opencv-dev feh python3-pip vim x11-utils x11-apps\
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

WORKDIR /app

COPY src/requirements.txt .
RUN pip3 install -r requirements.txt

COPY src/detect.py .

CMD ["python3", "detect.py"]