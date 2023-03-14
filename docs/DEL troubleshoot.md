(qemu) qemu-system-aarch64: Could not find ROM image 'bl1.bin'
arm-tf missing. Rebuild it. ``make arm-tf''.

(qemu) qemu-system-aarch64: failed to load "Image"
Kernel missing. 

 regression_1000.c:(.text+0x3300): undefined reference to `sdp_basic_test'
missing CFG_SECURE_DATA_PATH=y  in make command

Failure to install dependencies of QEMU

If the installation fails, e.g. due to unmet dependency, it's likely that the source of your apt repository is not properly configured. A common cause is that you have previously installed packages from some third-party apt sources. Remove them from /etc/apt and do `apt update`. 

`$ make run-only QEMU_VIRTFS_ENABLE=y QEMU_VIRTFS_HOST_DIR=build/shared_folder` 

If the above command complains "shared_folder" not found, try passing an absolute path as the last argument

Include extra packages in rootfs? 

```
make buildroot QEMU_VIRTFS_ENABLE=y CFG_SECURE_DATA_PATH=y \
BR2_PACKAGE_BUSYBOX_SHOW_OTHERS=y \
CFG_TEE_RAM_VA_SIZE=0x00300000 -j `nproc`
```


