# First install WSL. Tons of info online. 

Make sure do WSL2, not WSL1.

# Install Ubuntu 20.04 LTS

Can list all available distros
```
wsl --list --online
```

Then install Ubuntu 20.04

```
wsl --install Ubuntu-20.04
```

If see an error at the end of installation, try
```
wsl --update
```

To list installed distros
```
wsl --list
```

To set the default distro for wsl, do
```
wsl -s Ubuntu-20.04
```

Then launch and check version: 
```
bash

$ lsb_release -a
xzl@DESKTOP-3ECE59G:/mnt/c/Users/xl6yq$ lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 20.04.3 LTS
Release:        20.04
Codename:       focal

```

## Build opteev8-qemu 

As usual... Check troubleshoot if needed.

## Run 

### Xterms
x11 apps (graphics) should work out of box on WSL2+Win10. You shouldn't need any extra packages such as x11 servers (Xming etc). To test it, do 
```
(WSL) xterm
```
(apt install any missing packages as prompted)

(04/2023) Works on Win 10 Enterprise 22H2; not working on Win 10 Education 21H2 which may need some elbow grease (manual tweak xserver, etc)

If above works, you can auto launch normal/secure worlds in their separate xterms, in one command line. 

Uncomment the three lines in build/Makefile. Note the ports
```
	  $(call launch-terminal,54320,"Normal World")
	  $(call launch-terminal,54321,"Secure World")
	  $(call wait-for-ports,54320,54321)
```

Then launch it as usual, e.g.  (MUST CHANGE ARGUMENTS AS NEEDED)
```
make run-only QEMU_VIRTFS_ENABLE=y QEMU_VIRTFS_HOST_DIR=`readlink -f shared_folder`
```

## Final results 
Screenshot 1 (Zhiming Xu)
![](tee-on-wsl-xterms.gif)

Screenshot 2 (FL)
![tee-one-wsl-xterms2](tee-one-wsl-xterms2.png)
