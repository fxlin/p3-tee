TARFILE=optee-qemuv8-students-`date +%m-%d-%Y`.tar

rm -f ${TARFILE}
ln -sf ${TARFILE} optee-qemuv8-students.tar

tar \
    cvvf ${TARFILE} \
    --exclude-from="exclude_file.txt" \
    optee-qemuv8/

