## Jetson YOLOv5 Object Detection

This project contains a Dockerized application that runs real-time object detection on a Jetson device using YOLOv5 and OpenCV. The application captures live video from a USB camera and performs object detection with bounding box visualization.

### Project Structure

- `src/detect.py`: The Python script that contains the object detection logic.
- `src/requirements.txt`: List of Python dependencies.
- `Dockerfile`: Instructions for building the Docker image.
- `docker-compose.yml`: Configuration for running the container using Docker Compose.

### Prerequisites

- A Jetson device with Docker and NVIDIA Container Toolkit installed.
- A USB camera connected to the Jetson device (e.g., Logitech camera).

### Building and Running the Application

1. Clone the repository and navigate to the project directory:

   ```bash
   git clone <repository_url>
   cd jetson-yolov5-detection