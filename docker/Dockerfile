FROM dockcross/linux-armv7l-musl

ENV DEFAULT_DOCKCROSS_IMAGE linux-armv7l-musl-v83x-python

# Install unzip
RUN apt-get install unzip

# Copy files
RUN mkdir -p /mnt/files
COPY ./files /mnt/files

# Install numpy
# RUN apt-get install python3-dev
# RUN pip install numpy==1.19.2
# RUN pip install numpy==1.21.5
# RUN pip install scikit-build
# RUN pip install pybind11

# Install dev package for python armhf
# RUN wget ftp.de.debian.org/debian/pool/main/p/python3.9/libpython3.9-dev_3.9.2-1_armhf.deb
# RUN dpkg -x libpython3.9-dev_3.9.2-1_armhf.deb ./armhf_python_extract
# RUN sudo cp -r armhf_python_extract/usr/include/arm-linux-gnueabihf /usr/include/

# Get Toolchain
RUN mkdir -p /opt/maix_toolchain/
RUN wget --quiet https://github.com/sipeed/MaixPy3/releases/download/20210613/v83x_linux_x86_python3.8_toolchain.zip
RUN unzip -q v83x_linux_x86_python3.8_toolchain.zip -d /opt/maix_toolchain


## Install Conda
ENV CONDA_DIR /opt/conda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
     /bin/bash ~/miniconda.sh -b -p /opt/conda

RUN chmod a=rwx -R $CONDA_DIR
# Put conda in path
ENV PATH=$CONDA_DIR/bin:$PATH
RUN conda env create --file /mnt/files/opencv-cross.yml
# Activate environment
ENV PATH /opt/conda/envs/opencv-cross/bin:$PATH

# Python Env
ENV _PYTHON_HOST_PLATFORM="linux-armv7l"
ENV PYTHONPATH="$MAIX_TOOLCHAIN/usr/lib/python3.8/site-packages:$MAIX_TOOLCHAIN//ipkg-install//usr/lib/python3.8/site-packages"
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONOPTIMIZE=""
ENV _python_sysroot="$MAIX_TOOLCHAIN/"
ENV _python_prefix="/usr"
ENV _python_exec_prefix="/usr"

# ToolChain Env
ENV MAIX_TOOLCHAIN="/opt/maix_toolchain/v83x_linux_x86_python3.8_toolchain"
ENV MAIX_TOOLCHAIN_SUNXI=$MAIX_TOOLCHAIN/toolchain-sunxi-musl/toolchain
ENV MAIX_BIN=$MAIX_TOOLCHAIN_SUNXI/bin
ENV STAGING_DIR=$MAIX_TOOLCHAIN

# C env
ENV CC="$MAIX_BIN/arm-openwrt-linux-muslgnueabi-gcc"
ENV CCSHARED="$MAIX_BIN/arm-openwrt-linux-muslgnueabi-gcc -fpic"
ENV CXX="$MAIX_BIN/arm-openwrt-linux-muslgnueabi-g++"
ENV LD="$MAIX_BIN/arm-openwrt-linux-muslgnueabi-gcc"
ENV LDSHARED="$MAIX_BIN/arm-openwrt-linux-muslgnueabi-gcc -shared"
ENV CFLAGS="-Os -pipe -march=armv7-a -mtune=cortex-a7 -mfpu=neon -fno-caller-saves -Wno-unused-result -mfloat-abi=hard  -Wformat -Werror=format-security -fdiagnostics-color=auto -fstack-protector -D_FORTIFY_SOURCE=1 -Wl,-z,now -Wl,-z,relro"
ENV CPPFLAGS="-I$MAIX_TOOLCHAIN/usr/include -I$MAIX_TOOLCHAIN_SUNXI/usr/include -I$MAIX_TOOLCHAIN_SUNXI/include -I$MAIX_TOOLCHAIN_SUNXI/include/fortify -I$MAIX_TOOLCHAIN/usr/include/python3.8"
ENV LDFLAGS="-L$MAIX_TOOLCHAIN/usr/lib -L$MAIX_TOOLCHAIN/lib -L$MAIX_TOOLCHAIN_SUNXI/usr/lib -L$MAIX_TOOLCHAIN_SUNXI/lib -znow -zrelro -lpython3.8"
