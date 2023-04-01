TARFILE=optee-qemuv8-students-`date +%m-%d-%Y`.tar

rm -f ${TARFILE}

# deploy any files...
cp -f README-students.md optee-qemuv8/

tar \
    cvvf ${TARFILE} \
    --exclude-from="exclude_file.txt" \
    optee-qemuv8/

ln -sf ${TARFILE} optee-qemuv8-students.tar
chmod a+r ${TARFILE}

