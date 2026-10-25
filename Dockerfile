# Qwen-Image-Edit Rapid AIO NSFW — RunPod Serverless ComfyUI worker
# Build on RunPod from your own copy of this repo (Dockerfile path = Dockerfile, build context = .).
# The build steps are downloaded from the original repo, so there is nothing to edit.

FROM runpod/worker-comfyui:5.10.0-base
ADD https://github.com/afterdark-workers/qwen-edit-rapid-aio/releases/latest/download/build.sh /build.sh
RUN sh /build.sh
ADD https://github.com/afterdark-workers/qwen-edit-rapid-aio/releases/latest/download/handler.py /handler.py
