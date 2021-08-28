#!/bin/bash
xhost +local:
sudo docker run -it --rm --runtime nvidia --network host --device /dev/video0:/dev/video0:mrw -e DISPLAY=$DISPLAY -v /tmp/.X11-unix/:/tmp/.X11-unix yolov5_deepsort python3.8 track.py --yolo_weights best.pt --source 0 --show-vid
