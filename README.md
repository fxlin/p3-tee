# FOR INSTRUCTORS: HOW TO PREPARE CODE FOR STUDENTS
------------------------------------
Put optee-qemuv8/ under here (too large to include in git repo)

* Update qemu_v8.mk, which contains things like ``make cleaner``

```bash
mv -f optee-qemuv8/build/qemu_v8.mk optee-qemuv8/build/qemu_v8.mk.saved
cp qemu_v8.mk optee-qemuv8/build/
```

* Go to optee-qemuv8-teachingonly/optee_examples, pull our example code, e.g. 
```
git pull git@github.com:fxlin/p3-tee-sample.git
```

* Run 0-XXX.sh 1-XX.sh, which will generate a tarball. (we avoid zipping for speed). It is like ~6GB. 

* Run 2/3-XX.sh is for testing. will unpack to ~/tmp/ and build the whole thing. 

* Distribute the tarball to students, e.g. 

```bash
# on granger1/2
cp optee-qemuv8-student.tar /home/students/``
```

# WHAT'S HERE
--------------------------
docs: the doc (website) 

0-2XXX.sh: scripts for packing a code tarball for distribution. will not clean: edk2, arm-tf, qemu; pack them as-is. Simplify stduents' building

99-XXX.sh: clean everything for a from-scratch build

exclude_file.txt: used by tar command in packing

ubuntu-22.04-patches: in mar 2023 we attempted to build this thing on 22.04. a number of host packages of buildroot failed. here are some patches to keep the build going. there may be more down the road but we decided to fall back to 20.04


