#!/bin/bash

BR_ROOTFS_PATH=buildroot/output/images/rootfs.ext4
BR_KERNEL_IMAGE_PATH=buildroot/output/images/Image

if [ -f "${BR_ROOTFS_PATH}" ] && [ -f "${BR_KERNEL_IMAGE_PATH}" ]; then
    echo "Skipping build."
else
    ./build.sh
fi

qemu-system-aarch64 \
    -M virt  \
    -cpu cortex-a53 -nographic -smp 1 \
    -kernel ${BR_KERNEL_IMAGE_PATH} \
    -append "rootwait root=/dev/vda console=ttyAMA0" \
    -netdev user,id=eth0,hostfwd=tcp::10022-:22  \
    -drive file=${BR_ROOTFS_PATH},if=none,format=raw,id=hd0 \
    -device virtio-blk-device,drive=hd0 -device virtio-rng-pci \
    -device virtio-net-device,netdev=eth0 \
