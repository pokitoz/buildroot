# buildroot

- Get buildroot as submodule (specific version tagged).
- Do a small build before to make sure all configs are pre-defined
  - You might see `No rule to make target 'linux-menuconfig`
    otherwise.
- Configure Buildroot through `make menuconfig`
- Configure Linux through `make linux_menuconfig`
- Setup the external modules
- Build the source
- Start on QEMU (root, root as login/password)

## Quick start

- Build using `./build.sh`
- Run using `./run.sh`

## Basic setup

- With `make menuconfig`
  - Set `Linux Kernel` config option
  - Set `Use default Architecture Config` config option
    Otherwise, you need to specify `BR2_LINUX_KERNEL_DEFCONFIG`.

- Export `BR2_EXTERNAL` to the path with the external build
- Export `BR2_DEFCONFIG` to the path with the custom config
