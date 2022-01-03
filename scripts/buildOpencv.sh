#!/bin/bash
opencv_python_path=/work/repos/opencv-python
opencv_path=$opencv_python_path/opencv
conda_python=/opt/conda/envs/opencv-cross/bin/python

# Get toolchain into env variables
source ./toolchainEnv.sh

# Copy maix toolchain cmake settings into opencv repo
#cp opencv-files/maix.toolchain.cmake $opencv_path/platforms/linux/

# Apply our patch to make python3 default
cp /mnt/files/makePy3Default.patch $opencv_path/
cd $opencv_path
git apply makePy3Default.patch

cd $opencv_python_path

export CMAKE_ARGS="-G 'Unix Makefiles' \
-DCMAKE_VERBOSE_MAKEFILE=ON  \
-DENABLE_NEON=ON \
-DENABLE_VFPV3=ON \
-DBUILD_OPENCV_PYTHON2=OFF \
-DBUILD_OPENCV_PYTHON3=ON \
-DPYTHON3_INCLUDE_PATH=$MAIX_TOOLCHAIN/usr/include/python3.8 \
-DPYTHON_INCLUDE_DIRS=$MAIX_TOOLCHAIN/usr/include/python3.8:$conda_python/../../lib/python3.8/site-packages/numpy/core/include \
-DPYTHON3_LIBRARIES=$MAIX_TOOLCHAIN/usr/lib/libpython3.8.so.1.0 \
-DPYTHON3_LIBRARY=$MAIX_TOOLCHAIN/usr/lib/libpython3.8.so.1.0 \
-DPYTHON_LIBRARIES=$MAIX_TOOLCHAIN/usr/lib/libpython3.8.so.1.0 \
-DPYTHON3_NUMPY_INCLUDE_DIRS=$conda_python/../../lib/python3.8/site-packages/numpy/core/include \
-DPYTHON3_EXECUTABLE=$conda_python \
-DPYTHON_DEFAULT_AVAILABLE=$conda_python \
-DPYTHON_DEFAULT_EXECUTABLE=$conda_python \
-DBUILD_EXAMPLES=ON \
-DPKG_CONFIG_PATH=$MAIX_TOOLCHAIN/usr/lib/pkgconfig \
-DPKG_CONFIG_LIBDIR=$MAIX_TOOLCHAIN/usr/lib/pkgconfig \
-DWITH_PROTOBUF=OFF \
-DCMAKE_TOOLCHAIN_FILE=$opencv_path/platforms/linux/arm.toolchain.cmake \
$opencv_path"

export VERBOSE=1
export ENABLE_HEADLESS=1

# Use all cores
export MAKEFLAGS="-j$(nproc)"

python setup.py bdist_wheel