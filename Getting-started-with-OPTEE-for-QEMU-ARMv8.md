To run examples on the QEMU ARMv8 emulator, we need first build OP-TEE for QEMU
ARMv8. You can install dependencies with this
[instruction](https://optee.readthedocs.io/building/prerequisites.html#prerequisites)
or use our [Dockerfile](Dockerfile).

Download OP-TEE for QEMU ARMv8 source code.

```sh
$ mkdir -p ~/bin
$ curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo && chmod a+x ~/bin/repo
$ export PATH=~/bin:$PATH
$ mkdir optee-qemuv8-3.4.0 && cd optee-qemuv8-3.4.0 && \
  repo init -q -u https://github.com/OP-TEE/manifest.git -m qemu_v8.xml -b 3.4.0 && \
  repo sync -j4 --no-clone-bundle
```

Build OP-TEE for QEMU ARMv8 and images.

```sh
$ cd build && \
  make -j2 toolchains && \
  make QEMU_VIRTFS_ENABLE=y CFG_TEE_RAM_VA_SIZE=0x00300000 -j$(nproc) && \
  make examples-install
```

Create a shared folder to share example host apps and TAs with QEMU guest system.

```sh
$ mkdir shared_folder
$ cp -r out/* shared_folder/
```

Run QEMU.

```sh
$ make run-only QEMU_VIRTFS_ENABLE=y QEMU_VIRTFS_HOST_DIR=$(pwd)/shared_folder
```

Mount shared folder in QEMU guest system (username: root).

```sh
$ mkdir shared && mount -t 9p -o trans=virtio host shared
```
Copy TAs to corresponding directory.

```sh
$ cd shared && cp ta/*.ta /lib/optee_armtz/
```

Execute host apps.

```sh
$ cd host
$ ./hello_world
original value is 29
inc value is 129
dec value is 29
Success
```

Note that if you are under a environment without GUI, you please comment out the following code in `qemu_v8.mk` and use `nc` instead.

```
diff --git a/qemu_v8.mk b/qemu_v8.mk
index 8271590..1c4a91b 100644
--- a/qemu_v8.mk
+++ b/qemu_v8.mk
@@ -163,9 +163,9 @@ run-only:
        ln -sf $(ROOT)/out-br/images/rootfs.cpio.gz $(BINARIES_PATH)/
        $(call check-terminal)
        $(call run-help)
-       $(call launch-terminal,54320,"Normal World")
-       $(call launch-terminal,54321,"Secure World")
-       $(call wait-for-ports,54320,54321)
+       # $(call launch-terminal,54320,"Normal World")
+       # $(call launch-terminal,54321,"Secure World")
+       # $(call wait-for-ports,54320,54321)
        cd $(BINARIES_PATH) && $(QEMU_PATH)/aarch64-softmmu/qemu-system-aarch64 \
                -nographic \
                -serial tcp:localhost:54320 -serial tcp:localhost:54321 \
```

Before start QEMU, run two `nc` to listen port `54320` and `54321`.

```
$ nc -l 127.0.0.1 -p 54320
$ nc -l 127.0.0.1 -p 54321
```

Then open QEMU by `make run-only`, and start by input `c`.