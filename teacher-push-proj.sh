# push to shared...
rsync -avxP optee-qemuv8/ /cs4414-shared/optee-qemuv8
cp env.sh  /cs4414-shared/optee-qemuv8/
cp student-pull-proj.sh /cs4414-shared/optee-qemuv8/

# rebuild everything under the shared dir, which is needed
cd /cs4414-shared/optee-qemuv8/
source env.sh
p3-rebuild-all

# set permission 
cd /cs4414-shared/optee-qemuv8/
# allow read by all
chmod -R a+r . 
# all entering subdirs by all
chmod -R a+rX . 

# can be deleted to avoid confusion
# /../out-br/images/rootfs.cpio.gz