#!/usr/bin/env bash

# To use: 
# go to the root dir of optee-qemuv8, 
# $ source env.sh
# will override many env variables in qemu_v8.mk

ROOT_PATH=`pwd`
BUILD_PATH=${ROOT_PATH}/build

p3-gen-random-ports() {
    export MY_NW_PORT=$((50000 + RANDOM % 15000)) # port: 50000-65000
    export MY_SW_PORT=$(expr ${MY_NW_PORT} + 1)
    echo "set ports: normal world: ${MY_NW_PORT}  sec world :${MY_SW_PORT}"
}

# will gen deterministic ports instead
p3-gen-hash-ports() {
    export MY_NW_PORT=`echo -n ${USER} | md5sum | cut -c1-8 | printf "%d\n" 0x$(cat -) | awk '{printf "%.0f\n", 50000 + (($1 / 0xffffffff) * 10000)}'`
    export MY_SW_PORT=$(expr ${MY_NW_PORT} + 1)
    echo "set ports: normal world: ${MY_NW_PORT}  sec world :${MY_SW_PORT}"
}


p3-console-normal() {
    nc -l 127.0.0.1 ${MY_NW_PORT}
    # also ... 
    # while true; do nc -l 127.0.0.1 ${MY_NW_PORT}; done        
}

p3-console-sec() {
    nc -l 127.0.0.1 ${MY_SW_PORT}
    # also ...
    # while true; do nc -l 127.0.0.1 ${MY_SW_PORT}; done        
}

p3-build-all() {
    export LD_LIBRARY_PATH=     # often cause problems in building...
    cd ${BUILD_PATH}
    make QEMU_VIRTFS_ENABLE=y CFG_SECURE_DATA_PATH=y CFG_TEE_RAM_VA_SIZE=0x00300000 -j`nproc`
}

p3-buildroot() {
    export LD_LIBRARY_PATH=     # often cause problems in building...
    cd ${BUILD_PATH}
    make buildroot QEMU_VIRTFS_ENABLE=y CFG_SECURE_DATA_PATH=y CFG_TEE_RAM_VA_SIZE=0x00300000 -j`nproc`
}

p3-buildroot-clean() {
    cd ${BUILD_PATH}
    make buildroot-cleaner
    p3-buildroot
}

p3-rebuild-all() {
    cd ${BUILD_PATH}
    make cleaner
    p3-build-all
}

p3-run-noxterm() {
    cd ${BUILD_PATH}
    make run-only QEMU_VIRTFS_ENABLE=y QEMU_VIRTFS_HOST_DIR=`readlink -f shared_folder`
}

p3-run() {
    cd ${BUILD_PATH}
    make run-only-xterm QEMU_VIRTFS_ENABLE=y QEMU_VIRTFS_HOST_DIR=`readlink -f shared_folder`
}

#   p3-build-all            Build everything. (In case of failure, see proj desc troubleshooting)
#   p3-rebuild-all          Clean everything then build everything 

usage() {
    cat << EOF 
AVAILABLE COMMANDS
------------------    
p3-buildroot            Build the root filesystem (inc. OPTEE)
p3-buildroot-clean      Clean the root filesystem (inc. OPTEE)
p3-run                  Run qemu with normal/secure world consoles as xterms. Local machine must have x server (see proj desc)

p3-run-noxterm          Run qemu. the normal/secure world consoles must be running 
p3-console-normal       Launch the normal-world console
p3-console-sec          Launch the secure-world console
EOF
}

#p3-gen-random-ports
p3-gen-hash-ports
usage
