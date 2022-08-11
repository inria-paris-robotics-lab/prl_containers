FROM ros:noetic-ros-base-focal

# Install generic packages
RUN apt-get update && \
    apt-get install -y -q --no-install-recommends wget && \
    rm -rf /var/lib/apt/lists/*

# Install miniconda
RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh 

ENV PATH="/root/miniconda3/bin:${PATH}"
ARG PATH="/root/miniconda3/bin:${PATH}"

