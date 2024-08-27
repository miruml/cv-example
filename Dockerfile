# Base image for Jetson devices with NVIDIA libraries
FROM dustynv/jetson-inference:r35.3.1

# Install additional dependencies if needed
RUN apt-get update && apt-get install -y \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory in the container
WORKDIR /app

# Copy the Python script into the container
COPY app.py .

# Set the entrypoint to run the Python script
CMD ["python3", "app.py"]
