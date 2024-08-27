# Jetson DetectNet Object Detection

This project contains a Dockerized application that runs object detection on a Jetson device using the `jetson-inference` and `jetson-utils` libraries. The application captures live video from the device's camera and performs real-time object detection.

## Project Structure

- `Dockerfile`: Instructions for building the Docker image.
- `compose.yml`: Configuration for running the container using Docker Compose.
- `app.py`: The Python script that contains the object detection logic.

## Prerequisites

- A Jetson device with Docker and NVIDIA Docker runtime installed.
- A camera connected to the Jetson device (e.g., `/dev/video0`).

## Building and Running the Application

1. Clone the repository and navigate to the project directory:

   ```bash
   git clone <repository_url>
   cd jetson-detectnet
