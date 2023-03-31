TARFILE=`readlink -f optee-qemuv8-students.tar`
TMPDIR=~/tmp/

mkdir -p ${TMPDIR}
cd ${TMPDIR}
rm -rf optee-qemuv8/
tar xvf ${TARFILE} 

cd optee-qemuv8/build
make QEMU_VIRTFS_ENABLE=y CFG_SECURE_DATA_PATH=y CFG_TEE_RAM_VA_SIZE=0x00300000 -j20

