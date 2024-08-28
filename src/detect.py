import cv2
import torch
from datetime import datetime

# Load YOLOv5 model
model = torch.hub.load("ultralytics/yolov5", "yolov5s", pretrained=True, trust_repo=True)

# Open camera
cap = cv2.VideoCapture(0)

while True:
    ret, frame = cap.read()
    if not ret:
        break

    # Perform detection
    results = model(frame)

    # Process detections
    for det in results.xyxy[0]:
        x1, y1, x2, y2, conf, cls = det
        if conf > 0.5:  # Confidence threshold
            label = model.names[int(cls)]
            current_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

            print(f"Label: {label}")
            print(f"Coordinates: ({int(x1)}, {int(y1)}) to ({int(x2)}, {int(y2)})")
            print(f"Time: {current_time}")
            print("-" * 50)  # Separator between detections

    if cv2.waitKey(1) & 0xFF == ord("q"):
        break

cap.release()
cv2.destroyAllWindows()
