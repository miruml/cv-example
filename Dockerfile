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

# Install Multimedia API samples & libs
RUN apt-get update && apt-get download nvidia-l4t-jetson-multimedia-api \
    && dpkg-deb -R ./nvidia-l4t-jetson-multimedia-api_*_arm64.deb ./mm-api \
    && cp -r ./mm-api/usr/src/jetson_multimedia_api /usr/src/jetson_multimedia_api \
    && ./mm-api/DEBIAN/postinst \
    && rm -rf ./nvidia-l4t-jetson-multimedia-api_*_arm64.deb ./mm-api

# Update libraries
RUN ldconfig

# Allow install of Microsoft fonts (needed for pyqt5 setup)
RUN echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections

# Install PyQT5 & other libs for ad_display 
RUN apt-get update && apt-get install -y  \
    python3-pyqt5 \
    python3-pyqt5.qtmultimedia \
    libqt5multimedia5-plugins \
    ubuntu-restricted-extras \
    libavcodec-extra \
    gstreamer1.0-plugins-ugly \
    gstreamer1.0-libav \
    # Additional requirements - Miru
    gstreamer1.0-x \
    libnvidia-encode-550 \
    ladspa-sdk \
    nvidia-settings\
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

WORKDIR /app

COPY src/requirements.txt .
RUN pip3 install -r requirements.txt

RUN nvidia-settings --assign CurrentMetaMode="nvidia-auto-select +0+0 { ForceFullCompositionPipeline = On }"; exit 0 
# Need for Qt
ENV LD_PRELOAD="/usr/lib/aarch64-linux-gnu/libgomp.so.1" 

COPY src/detect.py .

CMD ["python3", "detect.py"]