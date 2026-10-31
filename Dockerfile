FROM ubuntu:20.04


ENV PYTHONUNBUFFERED=1
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    python3 \
    python3-dev \
    python3-pip \
    python3-venv \
    wget \
    curl \
    git \
    vim \
    htop \
    build-essential \
    libgl1 \
    libglib2.0-0 \
    libsm6 \
    libxrender1 \
    libxext6 \
    libx11-6 \
    libgl1-mesa-glx \
    libglu1-mesa \
    libegl1-mesa \
    libgles2-mesa \
    libgtk2.0-0 \
    libgtk-3-0 \
    libqt5gui5 \
    libqt5widgets5 \
    libavcodec58 \
    libavformat58 \
    libswscale5 \
    libtiff5 \
    libjpeg8 \
    libpng16-16 \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

RUN python3 -m pip install --upgrade pip

RUN pip3 install --no-cache-dir \
    torch==2.0.1 \
    torchvision==0.15.2 \
    torchaudio==2.0.2 \
    tensorflow-cpu \
    matplotlib \
    numpy \
    opencv-python \
    jupyterlab \
    scipy \
    pandas \
    scikit-learn \
    torchshow \
    albumentations \ 
    git+https://github.com/aleju/imgaug \
    opencv-python \
    pillow \
    tqdm
COPY . /workspace
WORKDIR /workspace



RUN jupyter lab --generate-config && \
    echo "c.ServerApp.ip = '0.0.0.0'" >> /root/.jupyter/jupyter_lab_config.py && \
    echo "c.ServerApp.allow_root = True" >> /root/.jupyter/jupyter_lab_config.py

EXPOSE 8888

CMD ["jupyter", "lab", "--port=8888", "--no-browser", "--allow-root"]