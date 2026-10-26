# Qwen-Image-Edit Rapid AIO NSFW — RunPod Serverless ComfyUI worker
# Build on RunPod from your own copy of this repo (Dockerfile path = Dockerfile, build context = .).
# The build steps are downloaded from the original repo, so there is nothing to edit (LORAS below is optional).

# Only needed for Civitai links in LORAS: your Civitai API token (civitai.com → Account settings → API Keys → Read Only).
# If you put one here, keep your repo PRIVATE.
ARG CIVITAI_TOKEN=""
# >>> Optional — LoRAs built into the worker (each picture picks which to use): Civitai or Hugging Face links, each followed by
#     its strength (1 when left out), separated by spaces. Leave it empty for none. Example:
#     ARG LORAS="https://civitai.com/models/12345 0.8 https://huggingface.co/user/some-lora 0.6"   <<<
ARG LORAS=""

FROM runpod/worker-comfyui:5.10.0-base
ARG LORAS
ARG CIVITAI_TOKEN
ADD https://github.com/afterdark-workers/qwen-edit-rapid-aio/releases/latest/download/build.sh /build.sh
RUN sh /build.sh
ADD https://github.com/afterdark-workers/qwen-edit-rapid-aio/releases/latest/download/handler.py /handler.py
RUN python /handler.py --bake-loras
