#!/bin/sh
# Qwen-Image-Edit Rapid AIO NSFW — everything the worker image needs. The Dockerfile in your copy downloads this file
# from the original repo on every build, so fixes made there reach you with a rebuild.
set -eu

# file <dest> <url> <sha256>
file() {
  wget -q -O "$1" "$2"
  echo "$3  $1" | sha256sum -c - || { echo "ERROR: $1 changed upstream — wait for an update of the original repo, then rebuild" >&2; exit 1; }
}

# Phr00t/Qwen-Image-Edit-Rapid-AIO (Apache 2.0) (28.4 GB)
file /comfyui/models/checkpoints/qwen_rapid_aio_nsfw_v19.safetensors \
  "https://huggingface.co/Phr00t/Qwen-Image-Edit-Rapid-AIO/resolve/691024f438640508f8aa86414863fc15edfb8a84/v19/Qwen-Rapid-AIO-NSFW-v19.safetensors" \
  ba71575515709c9912560d1176b2386eaa49294fedc6ce57b9734aa57e91e5ac

# ComfyUI 0.34.0 (base image) → 0.39.0 — for the newest Qwen-Image-Edit nodes. Install into /opt/venv (the one ComfyUI actually runs with).
cd /comfyui
git fetch --depth 1 https://github.com/Comfy-Org/ComfyUI.git tag v0.39.0
git checkout -f v0.39.0
uv pip install --python /opt/venv/bin/python -r requirements.txt "transformers>=4.50.3,<5" "huggingface-hub<1.0"
timeout 300 /opt/venv/bin/python main.py --quick-test-for-ci --cpu
