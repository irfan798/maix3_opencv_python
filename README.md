# maix3_opencv_python
Docker builder for opencv-python for MAIX-II Dock ( Allwinner V831: Cortex-A7 and 0.2TOPS NPU )

Uses Docker Cross https://github.com/dockcross/dockcross

----

This repo uses submodules so clone it

```
git clone --recurse-submodules -j8 https://github.com/irfan798/maix3_opencv_python.git
``` 

Builds 
- MaixPy3:0.3.4
- OpenCV-Python:4.5.5

These builds works on **MAIX-II Dock** with firmware that has `Numpy:1.19.2`

If you are building for a firmware that has different numpy, please change numpy version accordingly in [opencv-cross.yml](./docker/opencv-cross.yml)

## Build Docker
```
docker build -t linux-armv7l-musl-v83x-python ./docker  
```
This will create an image which you can compile for v83x

### Create builder executable
```
docker run linux-armv7l-musl-v83x-python > ./dockcross-v83x
chmod +x ./dockcross-v83x
```

## Build MaixPy
```
./dockcross-v83x bash scripts/buildMaixPy3.sh 
```
Dist package will be in `./repos/MaixPy3/dist` folder

## Build Opencv-Python
```
./dockcross-v83x bash scripts/buildOpencv.sh 
```
Dist package will be in `./repos/opencv-python/dist` folder

## Building other projects
Check https://github.com/dockcross/dockcross#examples

```
./dockcross-v83x make
```

# Installing packages on MAIX-II Dock

## Connect to Maix-II Dock serial

Connect a USB-C cable to Maix-II Dock's `USB UART` port.
You shall be able to `screen` into firmware
```
 screen /dev/ttyUSB0 115200
```
TODO:Continue ssh setup


## Connect to Maix-II Dock using ADB
If you connect cable into Maix-II Dock's `USB OTG` port, you will should be able to use `adb` commands

```
adb push ./dist/maixpy3-0.3.*-cp38-cp38-linux_armv7l.whl /root/
adb shell "pip install ./root/maixpy3-0.3.*-cp38-cp38-linux_armv7l.whl --upgrade"
```