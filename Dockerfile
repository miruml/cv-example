ARG TAG=r36.2.0
FROM nvcr.io/nvidia/l4t-base:${TAG}

# Install essential utilities and Python packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    sudo \
    python3-pip \
    libopencv-dev \
    x11-apps \
    x11-utils \
    libx11-dev \
    libxext-dev \
    libxrender-dev \
    libxtst-dev \
    libxcomposite-dev \
    libxcursor-dev \
    libxdamage-dev \
    libxfixes-dev \
    libxi-dev \
    libxrandr-dev \
    libxv-dev \
    libopengl0 \
    qtbase5-dev \
    qtbase5-dev-tools \
    qt5-qmake \
    feh \
    gstreamer1.0-x \
    libxcb-xinerama0 \
    libxcb-icccm4 \
    libxcb-image0 \
    libxcb-keysyms1 \
    libxcb-randr0 \
    libxcb-render-util0 \
    libxcb-shape0 \
    libxcb-xkb1 \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

WORKDIR /app

# Copy and install Python requirements
COPY src/requirements.txt .
RUN pip3 install -r requirements.txt

# Set environment variable for Qt
ENV LD_PRELOAD="/usr/lib/aarch64-linux-gnu/libgomp.so.1" 
ENV QT_X11_NO_MITSHM=1

# Copy the application code
COPY src/detect.py .

CMD ["python3", "detect.py"]
