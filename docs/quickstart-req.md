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

## Check python versions 

On shell, do 

```
# It's okay this defaults to Python3.x
python --version
```

```
# Must exist
python2 
```

```
# Should not see any errors
python -c "import Crypto"
```

