pushd .
cd optee-qemuv8

# this requires FL's modification to Makefile 
# where "all / clean" will leave qemu, arm-tf, edk2 intact
cd build && make clean
popd
