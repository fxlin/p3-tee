# FOR INSTRUCTORS: HOW TO PREPARE CODE FOR STUDENTS
------------------------------------
*Jan 2024 updated: no longer a tarball, but shared with /cs4414-shared/ with symlinks*

Put optee-qemuv8/ under here, or as a symlink (too large to include in git repo)

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

Mirror optee code to /cs4414-shared/, cf the script teacher-push-dir.sh.

To test: 

login as TA (cs6456ta), run student-pull-dir.sh and then build (see that file for details)

