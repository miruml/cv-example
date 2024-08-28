ARG TAG=r36.2.0
FROM nvcr.io/nvidia/l4t-base:${TAG}

# Install essential utilities and Python packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-pip \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# Install OpenCV dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    libopencv-dev \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# Install additional requirements for OpenCV and YOLOv5
RUN apt-get update && apt-get install -y --no-install-recommends \
    feh x11-utils x11-apps gstreamer1.0-x \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

WORKDIR /app

COPY src/requirements.txt .
RUN pip3 install -r requirements.txt

# Environment variable for Qt (if necessary for OpenCV GUI operations)
ENV LD_PRELOAD="/usr/lib/aarch64-linux-gnu/libgomp.so.1" 

COPY src/detect.py .

CMD ["python3", "detect.py"]
