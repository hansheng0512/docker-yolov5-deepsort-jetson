
FROM nvcr.io/nvidia/l4t-pytorch:r32.5.0-pth1.6-py3

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt install -y cmake libgtk2.0-dev wget python3.8 python3.8-dev
# ffmpeg
RUN apt install -y libavcodec-dev libavformat-dev libavutil-dev libswscale-dev libavresample3
# gstreamer
RUN apt install -y libgstreamer-opencv1.0-0 libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libgstreamer1.0-dev
# pytorch
RUN python3.8 -m pip install --upgrade pip
RUN python3.8 -m pip install setuptools gdown
RUN gdown https://drive.google.com/uc?id=1V231Nmx42vXTo5nq_YsV_BouZwBE9vjh
RUN python3.8 -m pip install torch-1.8.0a0+56b43f4-cp38-cp38-linux_aarch64.whl
RUN git clone https://github.com/pytorch/vision torchvision
RUN apt install libomp5
RUN cd torchvision && git checkout v0.9.0 && python3.8 setup.py install
# opencv
RUN python3.8 -m pip install scikit-build
RUN git clone --recursive https://github.com/skvark/opencv-python.git
RUN cd opencv-python && python3.8 -m pip wheel . --verbose && find . -name "opencv_python*.whl" | xargs python3.8 -m pip install
# yolo + deepsort repo
RUN git clone --recurse-submodules https://github.com/hansheng0512/Yolov5_DeepSort_Pytorch.git
RUN cd Yolov5_DeepSort_Pytorch && python3.8 -m pip install -r requirements.txt
WORKDIR /Yolov5_DeepSort_Pytorch
