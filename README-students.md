# to clean
```
cd build 
make clean
```
For 1st time build or troubleshotting, may run `make cleaner`

# to build
```
cd build
make QEMU_VIRTFS_ENABLE=y CFG_SECURE_DATA_PATH=y CFG_TEE_RAM_VA_SIZE=0x00300000 -j20
```

# to run 
In two separate terminals (MUST CHANGE PORTS BELOW)
```
$ nc -l 127.0.0.1 54320
$ nc -l 127.0.0.1 54321
```

```
cd build
make run-only QEMU_VIRTFS_ENABLE=y QEMU_VIRTFS_HOST_DIR=`readlink -f shared_folder`
```

