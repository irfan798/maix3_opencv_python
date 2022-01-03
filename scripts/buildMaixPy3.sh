#!/bin/bash

# Get toolchain into env variables
source ./scripts/toolchainEnv.sh

# Go to maixpy3 dir
cd ./repos/MaixPy3 

# Use all cores
export MAKEFLAGS="-j$(nproc)"

# Execute setup
python setup.py bdist_wheel maix_v83x

# Show dist folder
echo "Created package:"
find $PWD/dist