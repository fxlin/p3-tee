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
  make QEMU_VIRTFS_ENABLE=y CFG_TEE_RAM_VA_SIZE=0x00300000 -j$(nproc)
```

Create a shared folder to share example host apps and TAs with QEMU guest system.

```sh
$ mkdir shared_folder
$ cp ALL_HOST_APPS_TAS shared_folder/
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
$ cd shared && cp *.ta /lib/optee_armtz/
```

Execute host apps.

```sh
$ ./hello_world
original value is 29
inc value is 129
dec value is 29
Success
```