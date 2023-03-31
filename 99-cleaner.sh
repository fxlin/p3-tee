# Clean everything, for building EVERYTHING from scratch
#  Often unnecessary for students, as building edk2, arm-tf can be funky

cd optee-qemuv8
rm -rf out-br

mv -f edk2/Conf/BuildEnv.sh edk2/Conf/BuildEnv.sh.old
cd edk2 && make clean
cd ..

cd trusted-firmware-a && make clean
cd ..

# this requires FL's modification to Makefile 
cd build && make cleaner 

