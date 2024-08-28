import cv2
import torch
from datetime import datetime
import os

# Load YOLOv5 model
model = torch.hub.load("ultralytics/yolov5", "yolov5s", pretrained=True, trust_repo=True)

# Open camera
cap = cv2.VideoCapture(0)

# Create output directory if it doesn't exist
output_dir = "/app/output"
os.makedirs(output_dir, exist_ok=True)

frame_count = 0

while True:
    ret, frame = cap.read()
    if not ret:
        break

    # Perform detection
    results = model(frame)

    # Process detections
    for det in results.xyxy[0]:
        x1, y1, x2, y2, conf, cls = det
        if conf > 0.60:  # Confidence threshold
            label = model.names[int(cls)]
            current_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

            # Print detection info
            print(f"Label: {label}")
            print(f"Coordinates: ({int(x1)}, {int(y1)}) to ({int(x2)}, {int(y2)})")
            print(f"Time: {current_time}")
            print("-" * 50)  # Separator between detections

            # Draw bounding box
            cv2.rectangle(frame, (int(x1), int(y1)), (int(x2), int(y2)), (0, 255, 0), 2)
            cv2.putText(
                frame,
                f"{label} {conf:.2f}",
                (int(x1), int(y1) - 10),
                cv2.FONT_HERSHEY_SIMPLEX,
                0.9,
                (0, 255, 0),
                2,
            )

    # Save the frame with bounding boxes
    output_path = os.path.join(output_dir, f"frame_{frame_count:04d}.jpg")
    cv2.imwrite(output_path, frame)
    print(f"Saved frame to {output_path}")

    frame_count += 1

    # Optional: limit the number of frames to process
    if frame_count >= 100:  # Process 100 frames then exit
        break

cap.release()
