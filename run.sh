#!/bin/bash

# https://stackoverflow.com/questions/28607538/how-to-debug-linux-kernel-modules-with-qemu/44095831#44095831

BR_ROOTFS_PATH=buildroot/output/images/rootfs.ext4
BR_KERNEL_IMAGE_PATH=buildroot/output/images/Image

if [ -f "${BR_ROOTFS_PATH}" ] && [ -f "${BR_KERNEL_IMAGE_PATH}" ]; then
    echo "Skipping build."
else
    ./build.sh
fi

#KGDB_PARAM_SERIAL="kgdboc=ttyS0 kgdbwait"
CONSOLE_PORT=1122
echo "Use 'telnet localhost ${CONSOLE_PORT}' to connect to the serial console."
qemu-system-aarch64 \
    -M virt \
    -cpu cortex-a53 \
    -nographic \
    -smp 1 \
    -kernel ${BR_KERNEL_IMAGE_PATH} \
    -append "nokaslr rootwait root=/dev/vda console=ttyAMA0 ${KGDB_PARAM_SERIAL}" \
    -netdev user,id=eth0,hostfwd=tcp::10022-:22  \
    -drive file=${BR_ROOTFS_PATH},if=none,format=raw,id=hd0 \
    -device virtio-blk-device,drive=hd0 \
    -device virtio-rng-pci \
    -device virtio-net-device,netdev=eth0 \
    -S \
    -gdb tcp::1234
