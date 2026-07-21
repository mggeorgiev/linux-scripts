#!/bin/bash
set -e

if ! command -v cloud-localds &> /dev/null; then
    echo "Error: cloud-image-utils is not installed."
    echo "Run: sudo apt install cloud-image-utils"
    exit 1
fi

VM_NAME="k3s01"
IMAGE_URL="https://cloud-images.ubuntu.com/daily/server/resolute/current/resolute-server-cloudimg-amd64.img"
BASE_IMG="resolute-base.qcow2"
VM_IMG="${VM_NAME}.qcow2"
DATA_IMG="${VM_NAME}_data.qcow2"
CLOUD_ISO="${VM_NAME}-cinit.iso"

# 1. Download the base image if not present
if [ ! -f "$BASE_IMG" ]; then
    wget -O "$BASE_IMG" "$IMAGE_URL"
fi

# --- 1. Selective Cleanup ---
echo "Cleaning up existing VM configuration..."
if virsh list --all --name | grep -q "^$VM_NAME$"; then
    virsh destroy "$VM_NAME" 2>/dev/null || true

    # CRITICAL: We do NOT use --remove-all-storage here.
    # This keeps the .qcow2 files safe on the host disk.
    virsh undefine "$VM_NAME"
fi

# Manually delete ONLY the OS overlay and the config ISO.
# We DO NOT run 'rm' on $DATA_IMG.
rm -f "$VM_IMG" "$CLOUD_ISO" user-data.tmp

# --- 2. Base Image Management ---
if [ ! -f "$BASE_IMG" ]; then
    echo "Downloading Ubuntu 26.04 base image..."
    wget -O "$BASE_IMG" "$IMAGE_URL"
fi

# --- 3. Disk Logic ---
echo "Creating fresh OS overlay..."
qemu-img create -f qcow2 -b "$BASE_IMG" -F qcow2 "$VM_IMG" 20G

# ONLY create the data disk if it is missing (first time run)
if [ ! -f "$DATA_IMG" ]; then
    echo "Data disk NOT found. Creating NEW 20GB disk..."
    qemu-img create -f qcow2 "$DATA_IMG" 20G
else
    echo ">>> PRESERVING EXISTING DATA DISK: $DATA_IMG <<<"
fi

# --- 4. Cloud-Init Prep ---
envsubst < user-data > user-data.tmp
cloud-localds "$CLOUD_ISO" user-data.tmp
rm user-data.tmp

# --- 5. Launch ---
virt-install \
  --name "$VM_NAME" \
  --memory 2048 \
  --vcpus 1 \
  --disk path="$VM_IMG",format=qcow2 \
  --disk path="$DATA_IMG",format=qcow2 \
  --disk path="$CLOUD_ISO",device=cdrom \
  --import \
  --os-variant ubuntu24.04 \
  --graphics none \
  --noautoconsole

echo "Redeploy complete. OS was reset, but $DATA_IMG was preserved."