# FOR INSTRUCTORS: HOW TO PREPARE CODE FOR STUDENTS
------------------------------------
*Jan 2024 updated: we no longer distribute a big tarball code to students (and ask them to compile from scratch); instead, we put code under the server's /cs4414-shared/ (precompiled as much as possible), to which the student's code contains symlinks to. See below*



Clone this repository. Then put optee-qemuv8/ under its root dir (or as a symlink). Note that optee-qemuv8 is not included in this repository (too big).

* Update qemu_v8.mk, which contains things like ``make cleaner``

```bash
mv -f optee-qemuv8/build/qemu_v8.mk optee-qemuv8/build/qemu_v8.mk.saved
cp qemu_v8.mk optee-qemuv8/build/
```

* More patches...
```
mv optee-qemuv8/build/br-ext/package/optee_examples/optee_examples.mk  optee-qemuv8/build/br-ext/package/optee_examples/optee_examples.mk.saved
cp optee_examples.mk optee-qemuv8/build/br-ext/package/optee_examples/
```

* Go to optee-qemuv8-teachingonly/optee_examples, pull our example code, e.g. 
```
git pull git@github.com:fxlin/p3-tee-sample.git
```

* Run script "teacher-push-dir.sh", which mirrors the optee code to /cs4414-shared/ and compile under that directory
* (cf student-pull-dir.sh to see how students will fetch the code)

## To test

login as TA (cs6456ta), run student-pull-dir.sh and then build (see that file for details)

