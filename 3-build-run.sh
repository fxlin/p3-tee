TMPDIR=~/tmp/

cd ${TMPDIR}/optee-qemuv8/build
make QEMU_VIRTFS_ENABLE=y CFG_SECURE_DATA_PATH=y CFG_TEE_RAM_VA_SIZE=0x00300000 -j40

# this will fail b/c no "nc..."
make run-only QEMU_VIRTFS_ENABLE=y QEMU_VIRTFS_HOST_DIR=`readlink -f shared_folder`

