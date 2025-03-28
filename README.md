# buildroot

- Get buildroot as submodule (specific version tagged).
- Do a small build before to make sure all configs are pre-defined
  - You might see `No rule to make target 'linux-menuconfig`
    otherwise.
- Configure Buildroot through `make menuconfig`
- Configure Linux through `make linux_menuconfig`
- Setup the external modules
- Build the source
- Start on QEMU (`root`/`root` as login/password)

## Basic setup

- With `make menuconfig`
  - Set `Linux Kernel` config option
  - Set `Use default Architecture Config` config option
    Otherwise, you need to specify `BR2_LINUX_KERNEL_DEFCONFIG`.

- Export `BR2_EXTERNAL` to the path with the external build
- Export `BR2_DEFCONFIG` to the path with the custom config

## Quick start

- Build using `./build.sh`
- Run using `./run.sh`


### Debug

#### QEMU gdb

- QEMU is configured to boot and wait for gdb
- On the host, use the following command:
  ```
  cd ~/buildroot/buildroot/output/build/linux-6.11.11/ &&
     aarch64-none-linux-gnu-gdb vmlinux \
        -ex 'target remote localhost:1234'
  ```
- Continue `c` to boot
- Use the `add-symbol` command printed on boot but specify the
  `.ko` from `../build/ioctl-<sha>/dev/ioctl.ko`
- Use `b ioctl_d_interface_open`
- Continue `c`
- Start on QEMU console `ioctl_app`

#### kgdb

- See config from `kernel-config-frag`
  - Setup GDB Script for Kernel debugging
  - Magic SysRq Key
  - KGDB: kernel debugger
    - KGDB: use kgdb over the serial console
    - KGDB_KDB
- On boot, the following message will print:
  ```
  KGDB: Registered I/O driver kgdboc
  KGDB: Waiting for connection from remote gdb...
  ```

##### On another platform than QEMU

- Update grub config parameter `GRUB_COMMAND_LINE_LINUX_DEFAULT` from
  `/etc/default/grub` by adding `KGDB_PARAM_SERIAL` content from `run.sh`.
- If ethernet needs to be used, instead of serial, we can pass the command:
  `` instead.

