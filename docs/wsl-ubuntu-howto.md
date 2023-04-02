First install WSL. Tons of info online. 

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

