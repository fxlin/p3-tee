# copy everything over...
# ... then...

# execute thsese under globally shared dir, e.g. 
# /cs4414-shared/optee-qemuv8

# allow read by all
chmod -R a+r . 
# all entering subdirs by all
chmod -R a+rX . 

# can be deleted to avoid confusion
/../out-br/images/rootfs.cpio.gz