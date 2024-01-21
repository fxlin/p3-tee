# to be executed under the root of the student dir

ROOT=~/optee-qemuv8
mkdir -p ${ROOT}
cd ${ROOT}

PREBUILT_ROOT=/cs4414-shared/optee-qemuv8

#ln -sf ${PREBUILT_ROOT}/build 
#ln -sf ${PREBUILT_ROOT}/buildroot 
ln -sf ${PREBUILT_ROOT}/edk2 
ln -sf ${PREBUILT_ROOT}/edk2-platforms 
ln -sf ${PREBUILT_ROOT}/env.sh
ln -sf ${PREBUILT_ROOT}/linux 
ln -sf ${PREBUILT_ROOT}/mbedtls 
ln -sf ${PREBUILT_ROOT}/qemu
ln -sf ${PREBUILT_ROOT}/soc_term
ln -sf ${PREBUILT_ROOT}/toolchains
ln -sf ${PREBUILT_ROOT}/trusted-firmware-a

# copy over 
cp -ax ${PREBUILT_ROOT}/build .
cp -ax ${PREBUILT_ROOT}/buildroot .
cp -ax ${PREBUILT_ROOT}/optee_* .
# out/bin containing all firmware symlinks, it also has a symlink for rootfs.cpio.gz which shall be overwritten by student command
cp -ax ${PREBUILT_ROOT}/out .   

