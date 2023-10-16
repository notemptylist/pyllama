ARG CUDA_IMAGE="11.8.0-devel-ubuntu22.04"
FROM nvidia/cuda:${CUDA_IMAGE}


RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y git build-essential \
    python3 python3-pip gcc wget bash cmake \
    ocl-icd-opencl-dev opencl-headers clinfo \ 
    libclblast-dev libopenblas-dev \
    && mkdir -p /etc/OpenCL/vendors \ 
    && echo "libnvidia-opencl.so.1" > /etc/OpenCL/vendors/nvidia.icd 

COPY . .

ENV CUDA_DOCKER_ARCH=all
ENV LLAMA_CUBLAS=1

RUN python3 -m pip install -U -r requirements.txt 

RUN CMAKE_ARGS="-DLLAMA_CUBLAS=on" python3 -m pip install llama-cpp-python
ENV MODEL=/models/mistral-7b-instruct-v0.1.Q4_0.gguf

ENV HOST 0.0.0.0
ENV PORT 8080
EXPOSE ${PORT}
CMD [ "python3", "main.py" ]