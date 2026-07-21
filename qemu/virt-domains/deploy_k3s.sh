#!/bin/bash
set -eo pipefail

# --- Configuration ---
export VM_NAME="k3s01"
export VM_PASS=$(cat password_file.txt)
export USER_DATA="user-data-k3s"
export VM_HASH=$(echo "$VM_PASS" | openssl passwd -6 -stdin)
VM_MAC="52:54:00:11:22:44"

# CUSTOM PATH
STORAGE_DIR="/vhdssd/images"
IMAGE_URL="https://cloud-images.ubuntu.com/daily/server/resolute/current/resolute-server-cloudimg-amd64.img"

DAILY_BASE="${STORAGE_DIR}/resolute-daily.qcow2"
VM_IMG="${STORAGE_DIR}/${VM_NAME}.qcow2"
DATA_IMG="${STORAGE_DIR}/${VM_NAME}_data.qcow2"

# --- 0. Directory Setup ---
if [ ! -d "$STORAGE_DIR" ]; then
    echo "Creating storage directory $STORAGE_DIR..."
    sudo mkdir -p "$STORAGE_DIR"
    sudo chown root:libvirt "$STORAGE_DIR"
    sudo chmod 775 "$STORAGE_DIR"
fi

# --- 1. Cleanup ---
echo "Cleaning up $VM_NAME..."
if virsh list --all --name | grep -q "^$VM_NAME$"; then
    virsh destroy "$VM_NAME" 2>/dev/null || true
    virsh undefine "$VM_NAME" 2>/dev/null || true
fi
rm -f "$VM_IMG" user-data.tmp

# --- 2. Refresh the Daily Base Image ---
echo "Syncing latest Ubuntu daily build..."
# Use curl -z to only download if remote image is newer than local DAILY_BASE
curl -s -S -z "$DAILY_BASE" -o "$DAILY_BASE" "$IMAGE_URL"

# --- 3. Disk Logic (Full Clone) ---
echo "Cloning standalone OS disk to $STORAGE_DIR..."
cp "$DAILY_BASE" "$VM_IMG"
qemu-img resize "$VM_IMG" 20G

if [ ! -f "$DATA_IMG" ]; then
    echo "Creating NEW 20GB data disk..."
    qemu-img create -f qcow2 "$DATA_IMG" 20G
fi

# --- 4. Cloud-Init Prep & Launch ---
envsubst < "$USER_DATA" > user-data.tmp

virt-install \
  --name "$VM_NAME" \
  --memory 2048 \
  --vcpus 2 \
  --disk path="$VM_IMG",format=qcow2 \
  --disk path="$DATA_IMG",format=qcow2 \
  --cloud-init user-data=user-data.tmp \
  --os-variant ubuntu24.04 \
  --network bridge=br1,mac="$VM_MAC" \
  --graphics none \
  --import \
  --noautoconsole

# Cleanup temp files
rm -f user-data.tmp#!/bin/bash
set -eo pipefail

# --- Configuration ---
export VM_NAME="k3s01"
export VM_PASS="password"
export USER_DATA="user-data-k3s"
export VM_HASH=$(echo "$VM_PASS" | openssl passwd -6 -stdin)
VM_MAC="52:54:00:11:22:44"

# CUSTOM PATH
STORAGE_DIR="/vhdssd/images"
IMAGE_URL="https://cloud-images.ubuntu.com/daily/server/resolute/current/resolute-server-cloudimg-amd64.img"

DAILY_BASE="${STORAGE_DIR}/resolute-daily.qcow2"
VM_IMG="${STORAGE_DIR}/${VM_NAME}.qcow2"
DATA_IMG="${STORAGE_DIR}/${VM_NAME}_data.qcow2"

# --- 0. Directory Setup ---
if [ ! -d "$STORAGE_DIR" ]; then
    echo "Creating storage directory $STORAGE_DIR..."
    sudo mkdir -p "$STORAGE_DIR"
    sudo chown root:libvirt "$STORAGE_DIR"
    sudo chmod 775 "$STORAGE_DIR"
fi

# --- 1. Cleanup ---
echo "Cleaning up $VM_NAME..."
if virsh list --all --name | grep -q "^$VM_NAME$"; then
    virsh destroy "$VM_NAME" 2>/dev/null || true
    virsh undefine "$VM_NAME" 2>/dev/null || true
fi
rm -f "$VM_IMG" user-data.tmp

# --- 2. Refresh the Daily Base Image ---
echo "Syncing latest Ubuntu daily build..."
# Use curl -z to only download if remote image is newer than local DAILY_BASE
curl -s -S -z "$DAILY_BASE" -o "$DAILY_BASE" "$IMAGE_URL"

# --- 3. Disk Logic (Full Clone) ---
echo "Cloning standalone OS disk to $STORAGE_DIR..."
cp "$DAILY_BASE" "$VM_IMG"
qemu-img resize "$VM_IMG" 20G

if [ ! -f "$DATA_IMG" ]; then
    echo "Creating NEW 20GB data disk..."
    qemu-img create -f qcow2 "$DATA_IMG" 20G
fi

# --- 4. Cloud-Init Prep & Launch ---
envsubst < "$USER_DATA" > user-data.tmp

virt-install \
  --name "$VM_NAME" \
  --memory 2048 \
  --vcpus 2 \
  --disk path="$VM_IMG",format=qcow2 \
  --disk path="$DATA_IMG",format=qcow2 \
  --cloud-init user-data=user-data.tmp \
  --os-variant ubuntu24.04 \
  --network bridge=br1,mac="$VM_MAC" \
  --graphics none \
  --import \
  --noautoconsole

# Cleanup temp files
rm -f user-data.tmp#!/bin/bash
set -eo pipefail

# --- Configuration ---
export VM_NAME="k3s01"
export VM_PASS="password"
export USER_DATA="user-data-k3s"
export VM_HASH=$(echo "$VM_PASS" | openssl passwd -6 -stdin)
VM_MAC="52:54:00:11:22:44"

# CUSTOM PATH
STORAGE_DIR="/vhdssd/images"
IMAGE_URL="https://cloud-images.ubuntu.com/daily/server/resolute/current/resolute-server-cloudimg-amd64.img"

DAILY_BASE="${STORAGE_DIR}/resolute-daily.qcow2"
VM_IMG="${STORAGE_DIR}/${VM_NAME}.qcow2"
DATA_IMG="${STORAGE_DIR}/${VM_NAME}_data.qcow2"

# --- 0. Directory Setup ---
if [ ! -d "$STORAGE_DIR" ]; then
    echo "Creating storage directory $STORAGE_DIR..."
    sudo mkdir -p "$STORAGE_DIR"
    sudo chown root:libvirt "$STORAGE_DIR"
    sudo chmod 775 "$STORAGE_DIR"
fi

# --- 1. Cleanup ---
echo "Cleaning up $VM_NAME..."
if virsh list --all --name | grep -q "^$VM_NAME$"; then
    virsh destroy "$VM_NAME" 2>/dev/null || true
    virsh undefine "$VM_NAME" 2>/dev/null || true
fi
rm -f "$VM_IMG" user-data.tmp

# --- 2. Refresh the Daily Base Image ---
echo "Syncing latest Ubuntu daily build..."
# Use curl -z to only download if remote image is newer than local DAILY_BASE
curl -s -S -z "$DAILY_BASE" -o "$DAILY_BASE" "$IMAGE_URL"

# --- 3. Disk Logic (Full Clone) ---
echo "Cloning standalone OS disk to $STORAGE_DIR..."
cp "$DAILY_BASE" "$VM_IMG"
qemu-img resize "$VM_IMG" 20G

if [ ! -f "$DATA_IMG" ]; then
    echo "Creating NEW 20GB data disk..."
    qemu-img create -f qcow2 "$DATA_IMG" 20G
fi

# --- 4. Cloud-Init Prep & Launch ---
envsubst < "$USER_DATA" > user-data.tmp

virt-install \
  --name "$VM_NAME" \
  --memory 2048 \
  --vcpus 2 \
  --disk path="$VM_IMG",format=qcow2 \
  --disk path="$DATA_IMG",format=qcow2 \
  --cloud-init user-data=user-data.tmp \
  --os-variant ubuntu24.04 \
  --network bridge=br1,mac="$VM_MAC" \
  --graphics none \
  --import \
  --noautoconsole

# Cleanup temp files
rm -f user-data.tmp#!/bin/bash
set -eo pipefail

# --- Configuration ---
export VM_NAME="k3s01"
export VM_PASS="password"
export USER_DATA="user-data-k3s"
export VM_HASH=$(echo "$VM_PASS" | openssl passwd -6 -stdin)
VM_MAC="52:54:00:11:22:44"

# CUSTOM PATH
STORAGE_DIR="/vhdssd/images"
IMAGE_URL="https://cloud-images.ubuntu.com/daily/server/resolute/current/resolute-server-cloudimg-amd64.img"

DAILY_BASE="${STORAGE_DIR}/resolute-daily.qcow2"
VM_IMG="${STORAGE_DIR}/${VM_NAME}.qcow2"
DATA_IMG="${STORAGE_DIR}/${VM_NAME}_data.qcow2"

# --- 0. Directory Setup ---
if [ ! -d "$STORAGE_DIR" ]; then
    echo "Creating storage directory $STORAGE_DIR..."
    sudo mkdir -p "$STORAGE_DIR"
    sudo chown root:libvirt "$STORAGE_DIR"
    sudo chmod 775 "$STORAGE_DIR"
fi

# --- 1. Cleanup ---
echo "Cleaning up $VM_NAME..."
if virsh list --all --name | grep -q "^$VM_NAME$"; then
    virsh destroy "$VM_NAME" 2>/dev/null || true
    virsh undefine "$VM_NAME" 2>/dev/null || true
fi
rm -f "$VM_IMG" user-data.tmp

# --- 2. Refresh the Daily Base Image ---
echo "Syncing latest Ubuntu daily build..."
# Use curl -z to only download if remote image is newer than local DAILY_BASE
curl -s -S -z "$DAILY_BASE" -o "$DAILY_BASE" "$IMAGE_URL"

# --- 3. Disk Logic (Full Clone) ---
echo "Cloning standalone OS disk to $STORAGE_DIR..."
cp "$DAILY_BASE" "$VM_IMG"
qemu-img resize "$VM_IMG" 20G

if [ ! -f "$DATA_IMG" ]; then
    echo "Creating NEW 20GB data disk..."
    qemu-img create -f qcow2 "$DATA_IMG" 20G
fi

# --- 4. Cloud-Init Prep & Launch ---
envsubst < "$USER_DATA" > user-data.tmp

virt-install \
  --name "$VM_NAME" \
  --memory 2048 \
  --vcpus 2 \
  --disk path="$VM_IMG",format=qcow2 \
  --disk path="$DATA_IMG",format=qcow2 \
  --cloud-init user-data=user-data.tmp \
  --os-variant ubuntu24.04 \
  --network bridge=br1,mac="$VM_MAC" \
  --graphics none \
  --import \
  --noautoconsole

# Cleanup temp files
rm -f user-data.tmp#!/bin/bash
set -eo pipefail

# --- Configuration ---
export VM_NAME="k3s01"
export VM_PASS="password"
export USER_DATA="user-data-k3s"
export VM_HASH=$(echo "$VM_PASS" | openssl passwd -6 -stdin)
VM_MAC="52:54:00:11:22:44"

# CUSTOM PATH
STORAGE_DIR="/vhdssd/images"
IMAGE_URL="https://cloud-images.ubuntu.com/daily/server/resolute/current/resolute-server-cloudimg-amd64.img"

DAILY_BASE="${STORAGE_DIR}/resolute-daily.qcow2"
VM_IMG="${STORAGE_DIR}/${VM_NAME}.qcow2"
DATA_IMG="${STORAGE_DIR}/${VM_NAME}_data.qcow2"

# --- 0. Directory Setup ---
if [ ! -d "$STORAGE_DIR" ]; then
    echo "Creating storage directory $STORAGE_DIR..."
    sudo mkdir -p "$STORAGE_DIR"
    sudo chown root:libvirt "$STORAGE_DIR"
    sudo chmod 775 "$STORAGE_DIR"
fi

# --- 1. Cleanup ---
echo "Cleaning up $VM_NAME..."
if virsh list --all --name | grep -q "^$VM_NAME$"; then
    virsh destroy "$VM_NAME" 2>/dev/null || true
    virsh undefine "$VM_NAME" 2>/dev/null || true
fi
rm -f "$VM_IMG" user-data.tmp

# --- 2. Refresh the Daily Base Image ---
echo "Syncing latest Ubuntu daily build..."
# Use curl -z to only download if remote image is newer than local DAILY_BASE
curl -s -S -z "$DAILY_BASE" -o "$DAILY_BASE" "$IMAGE_URL"

# --- 3. Disk Logic (Full Clone) ---
echo "Cloning standalone OS disk to $STORAGE_DIR..."
cp "$DAILY_BASE" "$VM_IMG"
qemu-img resize "$VM_IMG" 20G

if [ ! -f "$DATA_IMG" ]; then
    echo "Creating NEW 20GB data disk..."
    qemu-img create -f qcow2 "$DATA_IMG" 20G
fi

# --- 4. Cloud-Init Prep & Launch ---
envsubst < "$USER_DATA" > user-data.tmp

virt-install \
  --name "$VM_NAME" \
  --memory 2048 \
  --vcpus 2 \
  --disk path="$VM_IMG",format=qcow2 \
  --disk path="$DATA_IMG",format=qcow2 \
  --cloud-init user-data=user-data.tmp \
  --os-variant ubuntu24.04 \
  --network bridge=br1,mac="$VM_MAC" \
  --graphics none \
  --import \
  --noautoconsole

# Cleanup temp files
rm -f user-data.tmp#!/bin/bash
set -eo pipefail

# --- Configuration ---
export VM_NAME="k3s01"
export VM_PASS="password"
export USER_DATA="user-data-k3s"
export VM_HASH=$(echo "$VM_PASS" | openssl passwd -6 -stdin)
VM_MAC="52:54:00:11:22:44"

# CUSTOM PATH
STORAGE_DIR="/vhdssd/images"
IMAGE_URL="https://cloud-images.ubuntu.com/daily/server/resolute/current/resolute-server-cloudimg-amd64.img"

DAILY_BASE="${STORAGE_DIR}/resolute-daily.qcow2"
VM_IMG="${STORAGE_DIR}/${VM_NAME}.qcow2"
DATA_IMG="${STORAGE_DIR}/${VM_NAME}_data.qcow2"

# --- 0. Directory Setup ---
if [ ! -d "$STORAGE_DIR" ]; then
    echo "Creating storage directory $STORAGE_DIR..."
    sudo mkdir -p "$STORAGE_DIR"
    sudo chown root:libvirt "$STORAGE_DIR"
    sudo chmod 775 "$STORAGE_DIR"
fi

# --- 1. Cleanup ---
echo "Cleaning up $VM_NAME..."
if virsh list --all --name | grep -q "^$VM_NAME$"; then
    virsh destroy "$VM_NAME" 2>/dev/null || true
    virsh undefine "$VM_NAME" 2>/dev/null || true
fi
rm -f "$VM_IMG" user-data.tmp

# --- 2. Refresh the Daily Base Image ---
echo "Syncing latest Ubuntu daily build..."
# Use curl -z to only download if remote image is newer than local DAILY_BASE
curl -s -S -z "$DAILY_BASE" -o "$DAILY_BASE" "$IMAGE_URL"

# --- 3. Disk Logic (Full Clone) ---
echo "Cloning standalone OS disk to $STORAGE_DIR..."
cp "$DAILY_BASE" "$VM_IMG"
qemu-img resize "$VM_IMG" 20G

if [ ! -f "$DATA_IMG" ]; then
    echo "Creating NEW 20GB data disk..."
    qemu-img create -f qcow2 "$DATA_IMG" 20G
fi

# --- 4. Cloud-Init Prep & Launch ---
envsubst < "$USER_DATA" > user-data.tmp

virt-install \
  --name "$VM_NAME" \
  --memory 2048 \
  --vcpus 2 \
  --disk path="$VM_IMG",format=qcow2 \
  --disk path="$DATA_IMG",format=qcow2 \
  --cloud-init user-data=user-data.tmp \
  --os-variant ubuntu24.04 \
  --network bridge=br1,mac="$VM_MAC" \
  --graphics none \
  --import \
  --noautoconsole

# Cleanup temp files
rm -f user-data.tmp#!/bin/bash
set -eo pipefail

# --- Configuration ---
export VM_NAME="k3s01"
export VM_PASS="password"
export USER_DATA="user-data-k3s"
export VM_HASH=$(echo "$VM_PASS" | openssl passwd -6 -stdin)
VM_MAC="52:54:00:11:22:44"

# CUSTOM PATH
STORAGE_DIR="/vhdssd/images"
IMAGE_URL="https://cloud-images.ubuntu.com/daily/server/resolute/current/resolute-server-cloudimg-amd64.img"

DAILY_BASE="${STORAGE_DIR}/resolute-daily.qcow2"
VM_IMG="${STORAGE_DIR}/${VM_NAME}.qcow2"
DATA_IMG="${STORAGE_DIR}/${VM_NAME}_data.qcow2"

# --- 0. Directory Setup ---
if [ ! -d "$STORAGE_DIR" ]; then
    echo "Creating storage directory $STORAGE_DIR..."
    sudo mkdir -p "$STORAGE_DIR"
    sudo chown root:libvirt "$STORAGE_DIR"
    sudo chmod 775 "$STORAGE_DIR"
fi

# --- 1. Cleanup ---
echo "Cleaning up $VM_NAME..."
if virsh list --all --name | grep -q "^$VM_NAME$"; then
    virsh destroy "$VM_NAME" 2>/dev/null || true
    virsh undefine "$VM_NAME" 2>/dev/null || true
fi
rm -f "$VM_IMG" user-data.tmp

# --- 2. Refresh the Daily Base Image ---
echo "Syncing latest Ubuntu daily build..."
# Use curl -z to only download if remote image is newer than local DAILY_BASE
curl -s -S -z "$DAILY_BASE" -o "$DAILY_BASE" "$IMAGE_URL"

# --- 3. Disk Logic (Full Clone) ---
echo "Cloning standalone OS disk to $STORAGE_DIR..."
cp "$DAILY_BASE" "$VM_IMG"
qemu-img resize "$VM_IMG" 20G

if [ ! -f "$DATA_IMG" ]; then
    echo "Creating NEW 20GB data disk..."
    qemu-img create -f qcow2 "$DATA_IMG" 20G
fi

# --- 4. Cloud-Init Prep & Launch ---
envsubst < "$USER_DATA" > user-data.tmp

virt-install \
  --name "$VM_NAME" \
  --memory 2048 \
  --vcpus 2 \
  --disk path="$VM_IMG",format=qcow2 \
  --disk path="$DATA_IMG",format=qcow2 \
  --cloud-init user-data=user-data.tmp \
  --os-variant ubuntu24.04 \
  --network bridge=br1,mac="$VM_MAC" \
  --graphics none \
  --import \
  --noautoconsole

# Cleanup temp files
rm -f user-data.tmp#!/bin/bash
set -eo pipefail

# --- Configuration ---
export VM_NAME="k3s01"
export VM_PASS="password"
export USER_DATA="user-data-k3s"
export VM_HASH=$(echo "$VM_PASS" | openssl passwd -6 -stdin)
VM_MAC="52:54:00:11:22:44"

# CUSTOM PATH
STORAGE_DIR="/vhdssd/images"
IMAGE_URL="https://cloud-images.ubuntu.com/daily/server/resolute/current/resolute-server-cloudimg-amd64.img"

DAILY_BASE="${STORAGE_DIR}/resolute-daily.qcow2"
VM_IMG="${STORAGE_DIR}/${VM_NAME}.qcow2"
DATA_IMG="${STORAGE_DIR}/${VM_NAME}_data.qcow2"

# --- 0. Directory Setup ---
if [ ! -d "$STORAGE_DIR" ]; then
    echo "Creating storage directory $STORAGE_DIR..."
    sudo mkdir -p "$STORAGE_DIR"
    sudo chown root:libvirt "$STORAGE_DIR"
    sudo chmod 775 "$STORAGE_DIR"
fi

# --- 1. Cleanup ---
echo "Cleaning up $VM_NAME..."
if virsh list --all --name | grep -q "^$VM_NAME$"; then
    virsh destroy "$VM_NAME" 2>/dev/null || true
    virsh undefine "$VM_NAME" 2>/dev/null || true
fi
rm -f "$VM_IMG" user-data.tmp

# --- 2. Refresh the Daily Base Image ---
echo "Syncing latest Ubuntu daily build..."
# Use curl -z to only download if remote image is newer than local DAILY_BASE
curl -s -S -z "$DAILY_BASE" -o "$DAILY_BASE" "$IMAGE_URL"

# --- 3. Disk Logic (Full Clone) ---
echo "Cloning standalone OS disk to $STORAGE_DIR..."
cp "$DAILY_BASE" "$VM_IMG"
qemu-img resize "$VM_IMG" 20G

if [ ! -f "$DATA_IMG" ]; then
    echo "Creating NEW 20GB data disk..."
    qemu-img create -f qcow2 "$DATA_IMG" 20G
fi

# --- 4. Cloud-Init Prep & Launch ---
envsubst < "$USER_DATA" > user-data.tmp

virt-install \
  --name "$VM_NAME" \
  --memory 2048 \
  --vcpus 2 \
  --disk path="$VM_IMG",format=qcow2 \
  --disk path="$DATA_IMG",format=qcow2 \
  --cloud-init user-data=user-data.tmp \
  --os-variant ubuntu24.04 \
  --network bridge=br1,mac="$VM_MAC" \
  --graphics none \
  --import \
  --noautoconsole

# Cleanup temp files
rm -f user-data.tmp#!/bin/bash
set -eo pipefail

# --- Configuration ---
export VM_NAME="k3s01"
export VM_PASS="password"
export USER_DATA="user-data-k3s"
export VM_HASH=$(echo "$VM_PASS" | openssl passwd -6 -stdin)
VM_MAC="52:54:00:11:22:44"

# CUSTOM PATH
STORAGE_DIR="/vhdssd/images"
IMAGE_URL="https://cloud-images.ubuntu.com/daily/server/resolute/current/resolute-server-cloudimg-amd64.img"

DAILY_BASE="${STORAGE_DIR}/resolute-daily.qcow2"
VM_IMG="${STORAGE_DIR}/${VM_NAME}.qcow2"
DATA_IMG="${STORAGE_DIR}/${VM_NAME}_data.qcow2"

# --- 0. Directory Setup ---
if [ ! -d "$STORAGE_DIR" ]; then
    echo "Creating storage directory $STORAGE_DIR..."
    sudo mkdir -p "$STORAGE_DIR"
    sudo chown root:libvirt "$STORAGE_DIR"
    sudo chmod 775 "$STORAGE_DIR"
fi

# --- 1. Cleanup ---
echo "Cleaning up $VM_NAME..."
if virsh list --all --name | grep -q "^$VM_NAME$"; then
    virsh destroy "$VM_NAME" 2>/dev/null || true
    virsh undefine "$VM_NAME" 2>/dev/null || true
fi
rm -f "$VM_IMG" user-data.tmp

# --- 2. Refresh the Daily Base Image ---
echo "Syncing latest Ubuntu daily build..."
# Use curl -z to only download if remote image is newer than local DAILY_BASE
curl -s -S -z "$DAILY_BASE" -o "$DAILY_BASE" "$IMAGE_URL"

# --- 3. Disk Logic (Full Clone) ---
echo "Cloning standalone OS disk to $STORAGE_DIR..."
cp "$DAILY_BASE" "$VM_IMG"
qemu-img resize "$VM_IMG" 20G

if [ ! -f "$DATA_IMG" ]; then
    echo "Creating NEW 20GB data disk..."
    qemu-img create -f qcow2 "$DATA_IMG" 20G
fi

# --- 4. Cloud-Init Prep & Launch ---
envsubst < "$USER_DATA" > user-data.tmp

virt-install \
  --name "$VM_NAME" \
  --memory 2048 \
  --vcpus 2 \
  --disk path="$VM_IMG",format=qcow2 \
  --disk path="$DATA_IMG",format=qcow2 \
  --cloud-init user-data=user-data.tmp \
  --os-variant ubuntu24.04 \
  --network bridge=br1,mac="$VM_MAC" \
  --graphics none \
  --import \
  --noautoconsole

# Cleanup temp files
rm -f user-data.tmp#!/bin/bash
set -eo pipefail

# --- Configuration ---
export VM_NAME="k3s01"
export VM_PASS="password"
export USER_DATA="user-data-k3s"
export VM_HASH=$(echo "$VM_PASS" | openssl passwd -6 -stdin)
VM_MAC="52:54:00:11:22:44"

# CUSTOM PATH
STORAGE_DIR="/vhdssd/images"
IMAGE_URL="https://cloud-images.ubuntu.com/daily/server/resolute/current/resolute-server-cloudimg-amd64.img"

DAILY_BASE="${STORAGE_DIR}/resolute-daily.qcow2"
VM_IMG="${STORAGE_DIR}/${VM_NAME}.qcow2"
DATA_IMG="${STORAGE_DIR}/${VM_NAME}_data.qcow2"

# --- 0. Directory Setup ---
if [ ! -d "$STORAGE_DIR" ]; then
    echo "Creating storage directory $STORAGE_DIR..."
    sudo mkdir -p "$STORAGE_DIR"
    sudo chown root:libvirt "$STORAGE_DIR"
    sudo chmod 775 "$STORAGE_DIR"
fi

# --- 1. Cleanup ---
echo "Cleaning up $VM_NAME..."
if virsh list --all --name | grep -q "^$VM_NAME$"; then
    virsh destroy "$VM_NAME" 2>/dev/null || true
    virsh undefine "$VM_NAME" 2>/dev/null || true
fi
rm -f "$VM_IMG" user-data.tmp

# --- 2. Refresh the Daily Base Image ---
echo "Syncing latest Ubuntu daily build..."
# Use curl -z to only download if remote image is newer than local DAILY_BASE
curl -s -S -z "$DAILY_BASE" -o "$DAILY_BASE" "$IMAGE_URL"

# --- 3. Disk Logic (Full Clone) ---
echo "Cloning standalone OS disk to $STORAGE_DIR..."
cp "$DAILY_BASE" "$VM_IMG"
qemu-img resize "$VM_IMG" 20G

if [ ! -f "$DATA_IMG" ]; then
    echo "Creating NEW 20GB data disk..."
    qemu-img create -f qcow2 "$DATA_IMG" 20G
fi

# --- 4. Cloud-Init Prep & Launch ---
envsubst < "$USER_DATA" > user-data.tmp

virt-install \
  --name "$VM_NAME" \
  --memory 2048 \
  --vcpus 2 \
  --disk path="$VM_IMG",format=qcow2 \
  --disk path="$DATA_IMG",format=qcow2 \
  --cloud-init user-data=user-data.tmp \
  --os-variant ubuntu24.04 \
  --network bridge=br1,mac="$VM_MAC" \
  --graphics none \
  --import \
  --noautoconsole

# Cleanup temp files
rm -f user-data.tmp#!/bin/bash
set -eo pipefail

# --- Configuration ---
export VM_NAME="k3s01"
export VM_PASS="password"
export USER_DATA="user-data-k3s"
export VM_HASH=$(echo "$VM_PASS" | openssl passwd -6 -stdin)
VM_MAC="52:54:00:11:22:44"

# CUSTOM PATH
STORAGE_DIR="/vhdssd/images"
IMAGE_URL="https://cloud-images.ubuntu.com/daily/server/resolute/current/resolute-server-cloudimg-amd64.img"

DAILY_BASE="${STORAGE_DIR}/resolute-daily.qcow2"
VM_IMG="${STORAGE_DIR}/${VM_NAME}.qcow2"
DATA_IMG="${STORAGE_DIR}/${VM_NAME}_data.qcow2"

# --- 0. Directory Setup ---
if [ ! -d "$STORAGE_DIR" ]; then
    echo "Creating storage directory $STORAGE_DIR..."
    sudo mkdir -p "$STORAGE_DIR"
    sudo chown root:libvirt "$STORAGE_DIR"
    sudo chmod 775 "$STORAGE_DIR"
fi

# --- 1. Cleanup ---
echo "Cleaning up $VM_NAME..."
if virsh list --all --name | grep -q "^$VM_NAME$"; then
    virsh destroy "$VM_NAME" 2>/dev/null || true
    virsh undefine "$VM_NAME" 2>/dev/null || true
fi
rm -f "$VM_IMG" user-data.tmp

# --- 2. Refresh the Daily Base Image ---
echo "Syncing latest Ubuntu daily build..."
# Use curl -z to only download if remote image is newer than local DAILY_BASE
curl -s -S -z "$DAILY_BASE" -o "$DAILY_BASE" "$IMAGE_URL"

# --- 3. Disk Logic (Full Clone) ---
echo "Cloning standalone OS disk to $STORAGE_DIR..."
cp "$DAILY_BASE" "$VM_IMG"
qemu-img resize "$VM_IMG" 20G

if [ ! -f "$DATA_IMG" ]; then
    echo "Creating NEW 20GB data disk..."
    qemu-img create -f qcow2 "$DATA_IMG" 20G
fi

# --- 4. Cloud-Init Prep & Launch ---
envsubst < "$USER_DATA" > user-data.tmp

virt-install \
  --name "$VM_NAME" \
  --memory 2048 \
  --vcpus 2 \
  --disk path="$VM_IMG",format=qcow2 \
  --disk path="$DATA_IMG",format=qcow2 \
  --cloud-init user-data=user-data.tmp \
  --os-variant ubuntu24.04 \
  --network bridge=br1,mac="$VM_MAC" \
  --graphics none \
  --import \
  --noautoconsole

# Cleanup temp files
rm -f user-data.tmp#!/bin/bash
set -eo pipefail

# --- Configuration ---
export VM_NAME="k3s01"
export VM_PASS="password"
export USER_DATA="user-data-k3s"
export VM_HASH=$(echo "$VM_PASS" | openssl passwd -6 -stdin)
VM_MAC="52:54:00:11:22:44"

# CUSTOM PATH
STORAGE_DIR="/vhdssd/images"
IMAGE_URL="https://cloud-images.ubuntu.com/daily/server/resolute/current/resolute-server-cloudimg-amd64.img"

DAILY_BASE="${STORAGE_DIR}/resolute-daily.qcow2"
VM_IMG="${STORAGE_DIR}/${VM_NAME}.qcow2"
DATA_IMG="${STORAGE_DIR}/${VM_NAME}_data.qcow2"

# --- 0. Directory Setup ---
if [ ! -d "$STORAGE_DIR" ]; then
    echo "Creating storage directory $STORAGE_DIR..."
    sudo mkdir -p "$STORAGE_DIR"
    sudo chown root:libvirt "$STORAGE_DIR"
    sudo chmod 775 "$STORAGE_DIR"
fi

# --- 1. Cleanup ---
echo "Cleaning up $VM_NAME..."
if virsh list --all --name | grep -q "^$VM_NAME$"; then
    virsh destroy "$VM_NAME" 2>/dev/null || true
    virsh undefine "$VM_NAME" 2>/dev/null || true
fi
rm -f "$VM_IMG" user-data.tmp

# --- 2. Refresh the Daily Base Image ---
echo "Syncing latest Ubuntu daily build..."
# Use curl -z to only download if remote image is newer than local DAILY_BASE
curl -s -S -z "$DAILY_BASE" -o "$DAILY_BASE" "$IMAGE_URL"

# --- 3. Disk Logic (Full Clone) ---
echo "Cloning standalone OS disk to $STORAGE_DIR..."
cp "$DAILY_BASE" "$VM_IMG"
qemu-img resize "$VM_IMG" 20G

if [ ! -f "$DATA_IMG" ]; then
    echo "Creating NEW 20GB data disk..."
    qemu-img create -f qcow2 "$DATA_IMG" 20G
fi

# --- 4. Cloud-Init Prep & Launch ---
envsubst < "$USER_DATA" > user-data.tmp

virt-install \
  --name "$VM_NAME" \
  --memory 2048 \
  --vcpus 2 \
  --disk path="$VM_IMG",format=qcow2 \
  --disk path="$DATA_IMG",format=qcow2 \
  --cloud-init user-data=user-data.tmp \
  --os-variant ubuntu24.04 \
  --network bridge=br1,mac="$VM_MAC" \
  --graphics none \
  --import \
  --noautoconsole

# Cleanup temp files
rm -f user-data.tmp#!/bin/bash
set -eo pipefail

# --- Configuration ---
export VM_NAME="k3s01"
export VM_PASS="password"
export USER_DATA="user-data-k3s"
export VM_HASH=$(echo "$VM_PASS" | openssl passwd -6 -stdin)
VM_MAC="52:54:00:11:22:44"

# CUSTOM PATH
STORAGE_DIR="/vhdssd/images"
IMAGE_URL="https://cloud-images.ubuntu.com/daily/server/resolute/current/resolute-server-cloudimg-amd64.img"

DAILY_BASE="${STORAGE_DIR}/resolute-daily.qcow2"
VM_IMG="${STORAGE_DIR}/${VM_NAME}.qcow2"
DATA_IMG="${STORAGE_DIR}/${VM_NAME}_data.qcow2"

# --- 0. Directory Setup ---
if [ ! -d "$STORAGE_DIR" ]; then
    echo "Creating storage directory $STORAGE_DIR..."
    sudo mkdir -p "$STORAGE_DIR"
    sudo chown root:libvirt "$STORAGE_DIR"
    sudo chmod 775 "$STORAGE_DIR"
fi

# --- 1. Cleanup ---
echo "Cleaning up $VM_NAME..."
if virsh list --all --name | grep -q "^$VM_NAME$"; then
    virsh destroy "$VM_NAME" 2>/dev/null || true
    virsh undefine "$VM_NAME" 2>/dev/null || true
fi
rm -f "$VM_IMG" user-data.tmp

# --- 2. Refresh the Daily Base Image ---
echo "Syncing latest Ubuntu daily build..."
# Use curl -z to only download if remote image is newer than local DAILY_BASE
curl -s -S -z "$DAILY_BASE" -o "$DAILY_BASE" "$IMAGE_URL"

# --- 3. Disk Logic (Full Clone) ---
echo "Cloning standalone OS disk to $STORAGE_DIR..."
cp "$DAILY_BASE" "$VM_IMG"
qemu-img resize "$VM_IMG" 20G

if [ ! -f "$DATA_IMG" ]; then
    echo "Creating NEW 20GB data disk..."
    qemu-img create -f qcow2 "$DATA_IMG" 20G
fi

# --- 4. Cloud-Init Prep & Launch ---
envsubst < "$USER_DATA" > user-data.tmp

virt-install \
  --name "$VM_NAME" \
  --memory 2048 \
  --vcpus 2 \
  --disk path="$VM_IMG",format=qcow2 \
  --disk path="$DATA_IMG",format=qcow2 \
  --cloud-init user-data=user-data.tmp \
  --os-variant ubuntu24.04 \
  --network bridge=br1,mac="$VM_MAC" \
  --graphics none \
  --import \
  --noautoconsole

# Cleanup temp files
rm -f user-data.tmp#!/bin/bash
set -eo pipefail

# --- Configuration ---
export VM_NAME="k3s01"
export VM_PASS="password"
export USER_DATA="user-data-k3s"
export VM_HASH=$(echo "$VM_PASS" | openssl passwd -6 -stdin)
VM_MAC="52:54:00:11:22:44"

# CUSTOM PATH
STORAGE_DIR="/vhdssd/images"
IMAGE_URL="https://cloud-images.ubuntu.com/daily/server/resolute/current/resolute-server-cloudimg-amd64.img"

DAILY_BASE="${STORAGE_DIR}/resolute-daily.qcow2"
VM_IMG="${STORAGE_DIR}/${VM_NAME}.qcow2"
DATA_IMG="${STORAGE_DIR}/${VM_NAME}_data.qcow2"

# --- 0. Directory Setup ---
if [ ! -d "$STORAGE_DIR" ]; then
    echo "Creating storage directory $STORAGE_DIR..."
    sudo mkdir -p "$STORAGE_DIR"
    sudo chown root:libvirt "$STORAGE_DIR"
    sudo chmod 775 "$STORAGE_DIR"
fi

# --- 1. Cleanup ---
echo "Cleaning up $VM_NAME..."
if virsh list --all --name | grep -q "^$VM_NAME$"; then
    virsh destroy "$VM_NAME" 2>/dev/null || true
    virsh undefine "$VM_NAME" 2>/dev/null || true
fi
rm -f "$VM_IMG" user-data.tmp

# --- 2. Refresh the Daily Base Image ---
echo "Syncing latest Ubuntu daily build..."
# Use curl -z to only download if remote image is newer than local DAILY_BASE
curl -s -S -z "$DAILY_BASE" -o "$DAILY_BASE" "$IMAGE_URL"

# --- 3. Disk Logic (Full Clone) ---
echo "Cloning standalone OS disk to $STORAGE_DIR..."
cp "$DAILY_BASE" "$VM_IMG"
qemu-img resize "$VM_IMG" 20G

if [ ! -f "$DATA_IMG" ]; then
    echo "Creating NEW 20GB data disk..."
    qemu-img create -f qcow2 "$DATA_IMG" 20G
fi

# --- 4. Cloud-Init Prep & Launch ---
envsubst < "$USER_DATA" > user-data.tmp

virt-install \
  --name "$VM_NAME" \
  --memory 2048 \
  --vcpus 2 \
  --disk path="$VM_IMG",format=qcow2 \
  --disk path="$DATA_IMG",format=qcow2 \
  --cloud-init user-data=user-data.tmp \
  --os-variant ubuntu24.04 \
  --network bridge=br1,mac="$VM_MAC" \
  --graphics none \
  --import \
  --noautoconsole

# Cleanup temp files
rm -f user-data.tmp#!/bin/bash
set -eo pipefail

# --- Configuration ---
export VM_NAME="k3s01"
export VM_PASS="password"
export USER_DATA="user-data-k3s"
export VM_HASH=$(echo "$VM_PASS" | openssl passwd -6 -stdin)
VM_MAC="52:54:00:11:22:44"

# CUSTOM PATH
STORAGE_DIR="/vhdssd/images"
IMAGE_URL="https://cloud-images.ubuntu.com/daily/server/resolute/current/resolute-server-cloudimg-amd64.img"

DAILY_BASE="${STORAGE_DIR}/resolute-daily.qcow2"
VM_IMG="${STORAGE_DIR}/${VM_NAME}.qcow2"
DATA_IMG="${STORAGE_DIR}/${VM_NAME}_data.qcow2"

# --- 0. Directory Setup ---
if [ ! -d "$STORAGE_DIR" ]; then
    echo "Creating storage directory $STORAGE_DIR..."
    sudo mkdir -p "$STORAGE_DIR"
    sudo chown root:libvirt "$STORAGE_DIR"
    sudo chmod 775 "$STORAGE_DIR"
fi

# --- 1. Cleanup ---
echo "Cleaning up $VM_NAME..."
if virsh list --all --name | grep -q "^$VM_NAME$"; then
    virsh destroy "$VM_NAME" 2>/dev/null || true
    virsh undefine "$VM_NAME" 2>/dev/null || true
fi
rm -f "$VM_IMG" user-data.tmp

# --- 2. Refresh the Daily Base Image ---
echo "Syncing latest Ubuntu daily build..."
# Use curl -z to only download if remote image is newer than local DAILY_BASE
curl -s -S -z "$DAILY_BASE" -o "$DAILY_BASE" "$IMAGE_URL"

# --- 3. Disk Logic (Full Clone) ---
echo "Cloning standalone OS disk to $STORAGE_DIR..."
cp "$DAILY_BASE" "$VM_IMG"
qemu-img resize "$VM_IMG" 20G

if [ ! -f "$DATA_IMG" ]; then
    echo "Creating NEW 20GB data disk..."
    qemu-img create -f qcow2 "$DATA_IMG" 20G
fi

# --- 4. Cloud-Init Prep & Launch ---
envsubst < "$USER_DATA" > user-data.tmp

virt-install \
  --name "$VM_NAME" \
  --memory 2048 \
  --vcpus 2 \
  --disk path="$VM_IMG",format=qcow2 \
  --disk path="$DATA_IMG",format=qcow2 \
  --cloud-init user-data=user-data.tmp \
  --os-variant ubuntu24.04 \
  --network bridge=br1,mac="$VM_MAC" \
  --graphics none \
  --import \
  --noautoconsole

# Cleanup temp files
rm -f user-data.tmp#!/bin/bash
set -eo pipefail

# --- Configuration ---
export VM_NAME="k3s01"
export VM_PASS="password"
export USER_DATA="user-data-k3s"
export VM_HASH=$(echo "$VM_PASS" | openssl passwd -6 -stdin)
VM_MAC="52:54:00:11:22:44"

# CUSTOM PATH
STORAGE_DIR="/vhdssd/images"
IMAGE_URL="https://cloud-images.ubuntu.com/daily/server/resolute/current/resolute-server-cloudimg-amd64.img"

DAILY_BASE="${STORAGE_DIR}/resolute-daily.qcow2"
VM_IMG="${STORAGE_DIR}/${VM_NAME}.qcow2"
DATA_IMG="${STORAGE_DIR}/${VM_NAME}_data.qcow2"

# --- 0. Directory Setup ---
if [ ! -d "$STORAGE_DIR" ]; then
    echo "Creating storage directory $STORAGE_DIR..."
    sudo mkdir -p "$STORAGE_DIR"
    sudo chown root:libvirt "$STORAGE_DIR"
    sudo chmod 775 "$STORAGE_DIR"
fi

# --- 1. Cleanup ---
echo "Cleaning up $VM_NAME..."
if virsh list --all --name | grep -q "^$VM_NAME$"; then
    virsh destroy "$VM_NAME" 2>/dev/null || true
    virsh undefine "$VM_NAME" 2>/dev/null || true
fi
rm -f "$VM_IMG" user-data.tmp

# --- 2. Refresh the Daily Base Image ---
echo "Syncing latest Ubuntu daily build..."
# Use curl -z to only download if remote image is newer than local DAILY_BASE
curl -s -S -z "$DAILY_BASE" -o "$DAILY_BASE" "$IMAGE_URL"

# --- 3. Disk Logic (Full Clone) ---
echo "Cloning standalone OS disk to $STORAGE_DIR..."
cp "$DAILY_BASE" "$VM_IMG"
qemu-img resize "$VM_IMG" 20G

if [ ! -f "$DATA_IMG" ]; then
    echo "Creating NEW 20GB data disk..."
    qemu-img create -f qcow2 "$DATA_IMG" 20G
fi

# --- 4. Cloud-Init Prep & Launch ---
envsubst < "$USER_DATA" > user-data.tmp

virt-install \
  --name "$VM_NAME" \
  --memory 2048 \
  --vcpus 2 \
  --disk path="$VM_IMG",format=qcow2 \
  --disk path="$DATA_IMG",format=qcow2 \
  --cloud-init user-data=user-data.tmp \
  --os-variant ubuntu24.04 \
  --network bridge=br1,mac="$VM_MAC" \
  --graphics none \
  --import \
  --noautoconsole

# Cleanup temp files
rm -f user-data.tmp#!/bin/bash
set -eo pipefail

# --- Configuration ---
export VM_NAME="k3s01"
export VM_PASS="password"
export USER_DATA="user-data-k3s"
export VM_HASH=$(echo "$VM_PASS" | openssl passwd -6 -stdin)
VM_MAC="52:54:00:11:22:44"

# CUSTOM PATH
STORAGE_DIR="/vhdssd/images"
IMAGE_URL="https://cloud-images.ubuntu.com/daily/server/resolute/current/resolute-server-cloudimg-amd64.img"

DAILY_BASE="${STORAGE_DIR}/resolute-daily.qcow2"
VM_IMG="${STORAGE_DIR}/${VM_NAME}.qcow2"
DATA_IMG="${STORAGE_DIR}/${VM_NAME}_data.qcow2"

# --- 0. Directory Setup ---
if [ ! -d "$STORAGE_DIR" ]; then
    echo "Creating storage directory $STORAGE_DIR..."
    sudo mkdir -p "$STORAGE_DIR"
    sudo chown root:libvirt "$STORAGE_DIR"
    sudo chmod 775 "$STORAGE_DIR"
fi

# --- 1. Cleanup ---
echo "Cleaning up $VM_NAME..."
if virsh list --all --name | grep -q "^$VM_NAME$"; then
    virsh destroy "$VM_NAME" 2>/dev/null || true
    virsh undefine "$VM_NAME" 2>/dev/null || true
fi
rm -f "$VM_IMG" user-data.tmp

# --- 2. Refresh the Daily Base Image ---
echo "Syncing latest Ubuntu daily build..."
# Use curl -z to only download if remote image is newer than local DAILY_BASE
curl -s -S -z "$DAILY_BASE" -o "$DAILY_BASE" "$IMAGE_URL"

# --- 3. Disk Logic (Full Clone) ---
echo "Cloning standalone OS disk to $STORAGE_DIR..."
cp "$DAILY_BASE" "$VM_IMG"
qemu-img resize "$VM_IMG" 20G

if [ ! -f "$DATA_IMG" ]; then
    echo "Creating NEW 20GB data disk..."
    qemu-img create -f qcow2 "$DATA_IMG" 20G
fi

# --- 4. Cloud-Init Prep & Launch ---
envsubst < "$USER_DATA" > user-data.tmp

virt-install \
  --name "$VM_NAME" \
  --memory 2048 \
  --vcpus 2 \
  --disk path="$VM_IMG",format=qcow2 \
  --disk path="$DATA_IMG",format=qcow2 \
  --cloud-init user-data=user-data.tmp \
  --os-variant ubuntu24.04 \
  --network bridge=br1,mac="$VM_MAC" \
  --graphics none \
  --import \
  --noautoconsole

# Cleanup temp files
rm -f user-data.tmp#!/bin/bash
set -eo pipefail

# --- Configuration ---
export VM_NAME="k3s01"
export VM_PASS="password"
export USER_DATA="user-data-k3s"
export VM_HASH=$(echo "$VM_PASS" | openssl passwd -6 -stdin)
VM_MAC="52:54:00:11:22:44"

# CUSTOM PATH
STORAGE_DIR="/vhdssd/images"
IMAGE_URL="https://cloud-images.ubuntu.com/daily/server/resolute/current/resolute-server-cloudimg-amd64.img"

DAILY_BASE="${STORAGE_DIR}/resolute-daily.qcow2"
VM_IMG="${STORAGE_DIR}/${VM_NAME}.qcow2"
DATA_IMG="${STORAGE_DIR}/${VM_NAME}_data.qcow2"

# --- 0. Directory Setup ---
if [ ! -d "$STORAGE_DIR" ]; then
    echo "Creating storage directory $STORAGE_DIR..."
    sudo mkdir -p "$STORAGE_DIR"
    sudo chown root:libvirt "$STORAGE_DIR"
    sudo chmod 775 "$STORAGE_DIR"
fi

# --- 1. Cleanup ---
echo "Cleaning up $VM_NAME..."
if virsh list --all --name | grep -q "^$VM_NAME$"; then
    virsh destroy "$VM_NAME" 2>/dev/null || true
    virsh undefine "$VM_NAME" 2>/dev/null || true
fi
rm -f "$VM_IMG" user-data.tmp

# --- 2. Refresh the Daily Base Image ---
echo "Syncing latest Ubuntu daily build..."
# Use curl -z to only download if remote image is newer than local DAILY_BASE
curl -s -S -z "$DAILY_BASE" -o "$DAILY_BASE" "$IMAGE_URL"

# --- 3. Disk Logic (Full Clone) ---
echo "Cloning standalone OS disk to $STORAGE_DIR..."
cp "$DAILY_BASE" "$VM_IMG"
qemu-img resize "$VM_IMG" 20G

if [ ! -f "$DATA_IMG" ]; then
    echo "Creating NEW 20GB data disk..."
    qemu-img create -f qcow2 "$DATA_IMG" 20G
fi

# --- 4. Cloud-Init Prep & Launch ---
envsubst < "$USER_DATA" > user-data.tmp

virt-install \
  --name "$VM_NAME" \
  --memory 2048 \
  --vcpus 2 \
  --disk path="$VM_IMG",format=qcow2 \
  --disk path="$DATA_IMG",format=qcow2 \
  --cloud-init user-data=user-data.tmp \
  --os-variant ubuntu24.04 \
  --network bridge=br1,mac="$VM_MAC" \
  --graphics none \
  --import \
  --noautoconsole

# Cleanup temp files
rm -f user-data.tmp#!/bin/bash
set -eo pipefail

# --- Configuration ---
export VM_NAME="k3s01"
export VM_PASS="password"
export USER_DATA="user-data-k3s"
export VM_HASH=$(echo "$VM_PASS" | openssl passwd -6 -stdin)
VM_MAC="52:54:00:11:22:44"

# CUSTOM PATH
STORAGE_DIR="/vhdssd/images"
IMAGE_URL="https://cloud-images.ubuntu.com/daily/server/resolute/current/resolute-server-cloudimg-amd64.img"

DAILY_BASE="${STORAGE_DIR}/resolute-daily.qcow2"
VM_IMG="${STORAGE_DIR}/${VM_NAME}.qcow2"
DATA_IMG="${STORAGE_DIR}/${VM_NAME}_data.qcow2"

# --- 0. Directory Setup ---
if [ ! -d "$STORAGE_DIR" ]; then
    echo "Creating storage directory $STORAGE_DIR..."
    sudo mkdir -p "$STORAGE_DIR"
    sudo chown root:libvirt "$STORAGE_DIR"
    sudo chmod 775 "$STORAGE_DIR"
fi

# --- 1. Cleanup ---
echo "Cleaning up $VM_NAME..."
if virsh list --all --name | grep -q "^$VM_NAME$"; then
    virsh destroy "$VM_NAME" 2>/dev/null || true
    virsh undefine "$VM_NAME" 2>/dev/null || true
fi
rm -f "$VM_IMG" user-data.tmp

# --- 2. Refresh the Daily Base Image ---
echo "Syncing latest Ubuntu daily build..."
# Use curl -z to only download if remote image is newer than local DAILY_BASE
curl -s -S -z "$DAILY_BASE" -o "$DAILY_BASE" "$IMAGE_URL"

# --- 3. Disk Logic (Full Clone) ---
echo "Cloning standalone OS disk to $STORAGE_DIR..."
cp "$DAILY_BASE" "$VM_IMG"
qemu-img resize "$VM_IMG" 20G

if [ ! -f "$DATA_IMG" ]; then
    echo "Creating NEW 20GB data disk..."
    qemu-img create -f qcow2 "$DATA_IMG" 20G
fi

# --- 4. Cloud-Init Prep & Launch ---
envsubst < "$USER_DATA" > user-data.tmp

virt-install \
  --name "$VM_NAME" \
  --memory 2048 \
  --vcpus 2 \
  --disk path="$VM_IMG",format=qcow2 \
  --disk path="$DATA_IMG",format=qcow2 \
  --cloud-init user-data=user-data.tmp \
  --os-variant ubuntu24.04 \
  --network bridge=br1,mac="$VM_MAC" \
  --graphics none \
  --import \
  --noautoconsole

# Cleanup temp files
rm -f user-data.tmp