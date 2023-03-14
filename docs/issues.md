# Common issues

## (qemu) qemu-system-aarch64: Could not find ROM image 'bl1.bin'
arm-tf missing. Rebuild it. ``make arm-tf''.

##  (qemu) qemu-system-aarch64: failed to load "Image"
Kernel missing. 

## regression_1000.c:(.text+0x3300): undefined reference to `sdp_basic_test'
missing CFG_SECURE_DATA_PATH=y  in make command

## Failure to install dependencies of QEMU
If the installation fails, e.g. due to unmet dependency, it's likely that the source of your apt repository is not properly configured. A common cause is that you have previously installed packages from some third-party apt sources. Remove them from /etc/apt and do `apt update`. 

## shared_folder not found
`$ make run-only QEMU_VIRTFS_ENABLE=y QEMU_VIRTFS_HOST_DIR=build/shared_folder` 

If the above command complains "shared_folder" not found, try passing an absolute path as the last argument

## Include extra packages in rootfs? 

```
make buildroot QEMU_VIRTFS_ENABLE=y CFG_SECURE_DATA_PATH=y \
BR2_PACKAGE_BUSYBOX_SHOW_OTHERS=y \
CFG_TEE_RAM_VA_SIZE=0x00300000 -j `nproc`
```

## "No SOI" from SOD (secure world console)

meaning it fails to decode an image as .jpg. Can be benign if the image is not jpg, e.g. PNG.

## TEE failed to allocate ptes...

Secure world: "E/TC:0 alloc_pgt:281 5 page tables not available"

Cause: insufficient pgt cache for nw/sw shared memory. 

Solution: 

optee_os/core/arch/arm/include/mm.pgt_cache.h

`#define PGT_CACHE_SIZE 32`

https://github.com/OP-TEE/optee_os/issues/2178#issuecomment-374671101



## Failed to mount rootfs

Students reported that a recent Linux kernel failed to mount the rootfs which is ext2. Related boot log: 

```
[    1.304029] uart-pl011 9000000.pl011: no DMA platform data                                                                                                                                            │····································[    1.309704] VFS: Cannot open root device "vda2" or unknown-block(0,0): error -6                                                                                                                       │····································[    1.310024] Please append a correct "root=" boot option; here are the available partitions:                                                                                                           │····································[    1.310863] 1f00           65536 mtdblock0                                                                                                                                                            │····································[    1.310980]  (driver?)                                                                                                                                                                                │····································[    1.311461] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)                                                                                                            │····································[    1.311933] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.16.0-gdbeb6ea978fc #1                                                                                                                         │····································[    1.312256] Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015                                                                                                                           │····································[    1.312730] Call trace:                                                                                                                                                                               │····································[    1.312864]  dump_backtrace+0x0/0x1b0                                                                                                                                                                 │····································[    1.313196]  show_stack+0x18/0x68                                                                                                                                                                     │····································[    1.313358]  dump_stack_lvl+0x68/0x84                                                                                                                                                                 │····································[    1.313523]  dump_stack+0x18/0x34                                                                                                                                                                     │····································[    1.313663]  panic+0x164/0x324                                                                                                                                                                        │····································[    1.313793]  mount_block_root+0x130/0x20c                                                                                                                                                             │····································[    1.313953]  mount_root+0x1e0/0x214                                                                                                                                                                   │····································[    1.314091]  prepare_namespace+0x12c/0x16c                                                                                                                                                            │····································[    1.314340]  kernel_init_freeable+0x250/0x294                                                                                                                                                         │····································[    1.314621]  kernel_init+0x24/0x130                                                                                                                                                                   │····································[    1.314771]  ret_from_fork+0x10/0x20                                                                                                                                                                  │····································[    1.315194] SMP: stopping secondary CPUs                                                                                                                                                              │····································[    1.315679] Kernel Offset: 0x516c3b920000 from 0xffff800010000000                                                                                                                                     │·······························�····[    1.315912] PHYS_OFFSET: 0xffffdb4d00000000                                                                                                                                                           │····································[    1.316085] CPU features: 0x2,200018c2,00000846                                                                                                                                                       │····································[    1.316433] Memory Limit: none                                                                                                                                                                        │····································[    1.976015] ---[ end Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0) ]---
```

Kernel version: dbeb6ea97; 5.16.0

Strangely, the kernel config contains EXT2/3/4 as it should. No idea what caused the problem. 

Some students reported success when they repack rootfs as ext4

Note that `.repo/manifests/qemu_v8.xml` does not specify the release of Linux (as oppposed to other projects)

```
...
<!-- linaro-swg gits -->                                                                                                                         
<project path="linux"                name="linaro-swg/linux.git"                  revision="optee" clone-depth="1" />
```

So change that to an earlier version: 
```
<project path="linux"                name="linaro-swg/linux.git"                  revision="refs/tags/optee-3.10.0" clone-depth="1" />
```

Then `repo sync ...` you should be able to boot Linux fine. 


### Related dicussion:
* https://piazza.com/class/ky1ydg1ni7fty?cid=192
* https://piazza.com/class/ky1ydg1ni7fty?cid=190
