# On cleaning up OPTEE build

I found it's quite painful. There seems no global target for cleaning up everything and do a rebuild. (e.g. if you rename your directories, things will break; and you want to do a clean build). 

The best approach I found is to clean up individual targets. Go to build/. Then type `make <tab>`. It will list all targets. Execute targets end with -clean. e.g. `make optee-os-clean`

edk2 seems to be in particular problematic. It's build environment, `edk2/Conf/BuildEnv.sh`, always contains stale configurations that will make `build edk2-clean` fail. Just manually rename or remove it, then do a clean build of edk2. 



