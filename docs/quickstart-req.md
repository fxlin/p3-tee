# Prerequisite: optee local build (WSL, Linux)

**THIS IS FOR LOCAL BUILD ONLY.**

Mar 2023:

Win owner: 

* Must have WSL2. Then installs: Ubuntu == 20.04. Other distro/version: unsupported. 

Linux owner: 

* Install Ubuntu 20.04. Native or in a container. Other distro: unsupported. 

# Apt get

As suggested [here](https://optee.readthedocs.io/en/latest/building/prerequisites.html): 

```bash
sudo apt install \
  android-tools-adb \
  android-tools-fastboot \
  autoconf \
  automake \
  bc \
  bison \
  build-essential \
  ccache \
  cscope \
  curl \
  device-tree-compiler \
  expect \
  flex \
  ftp-upload \
  gdisk \
  iasl \
  libattr1-dev \
  libcap-dev \
  libfdt-dev \
  libftdi-dev \
  libglib2.0-dev \
  libgmp3-dev \
  libhidapi-dev \
  libmpc-dev \
  libncurses5-dev \
  libpixman-1-dev \
  libssl-dev \
  libtool \
  make \
  mtools \
  netcat \
  ninja-build \
  python3-crypto \
  python3-cryptography \
  python3-pip \
  python3-pyelftools \
  python3-serial \
  rsync \
  unzip \
  uuid-dev \
  xdg-utils \
  xterm \
  xz-utils \
  zlib1g-dev
```

In addition: 
```
sudo apt install python3-pycryptodome python-is-python3 python2
```

In addition, to support the debugging script: 

```
sudo apt install binutils-aarch64-linux-gnu
```

## Check Python versions 

On shell, do 

```
# should be Python3.x. If not, install python-is-python3 (see above)
python --version
# python3 should work fine, 
python3
which python3
# if missing .so, do "module unload python3-xxx" and fallback to Ubuntu's python3 (insteawd of the one in modules under /sw/..)
# also, deactivate conda, if any
conda deactivate
```

```
# Check python2, which must exist
python2 
```

```
# Should not see any errors. On shell, do 
python -c "import Crypto"
python -c "import Cryptodome"
python -c "from elftools.elf.elffile import ELFFile"

# if elftools is missing, must do (why python3-pyelftools inadequate?)
# this only installs locally, but that's recommended
pip3 install pyelftools
pip3 install pycryptodome
```

