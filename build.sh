#!/bin/bash -e

export PATH_EXTERNAL_BR="$(pwd)/external"

# Define config
make -C buildroot defconfig \
            BR2_EXTERNAL=${PATH_EXTERNAL_BR} \
            BR2_DEFCONFIG=${PATH_EXTERNAL_BR}/configs/qemu_defconfig

# Build everything
make -C buildroot BR2_EXTERNAL=${PATH_EXTERNAL_BR}
