# Howto: cleaning up the OPTEE build

I found it's quite painful. There seems no global target for cleaning up everything and do a rebuild. (e.g. if you rename your directories, things will break; and you want to do a clean build). 

The best approach I found is to clean up individual targets. Go to build/. Then type `make <tab>`. It will list all targets. Execute targets end with -clean. e.g. `make optee-os-clean`

```
mv edk2/Conf/BuildEnv.sh /tmp
```

Explanation: edk2 seems to be in particular problematic. It's build environment, `edk2/Conf/BuildEnv.sh`, always contains stale configurations. Symptoms: `make edk2` cannot find build command; `make edk2-clean` fails, etc. 

* Just manually rename or remove it, then do a clean build of edk2. 
* Go to the top directory, do `mkdir edk2-platform`. Just to make the clean script happy.

```
cd trusted-firmware-a
make clean
```

Explanation: arm-tf can be problematic. do `make arm-tf-clean` under `build` does not clean tools like `tools/fiptool/fiptool`, which may link to libs that have stale paths (e.g. tools/fiptool/fiptool: error while loading shared libraries: libcrypto.so.3: cannot open shared...)

Then go to build/, do `make clean`. It should finish without any errors. 





