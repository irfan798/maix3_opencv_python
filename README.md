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

If you are building for a firmware that has different numpy, please change numpy version accordingly in [opencv-cross.yml](./docker/files/opencv-cross.yml)

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

## Connect to Maix-II Dock using ADB
If you connect cable into Maix-II Dock's `USB OTG` port, you will should be able to use `adb` commands

Check with `adb devices -l`

```
adb push ./repos/opencv-python/dist/opencv_python_headless-4.5.5.62-cp38-cp38-linux_armv7l.whl /root/
adb shell "pip install /root/opencv_python_headless-4.5.5.62-cp38-cp38-linux_armv7l.whl --upgrade" 
```

## Connect to Maix-II Dock serial

Connect a USB-C cable to Maix-II Dock's `USB UART` port.
You shall be able to `screen` into firmware
```
 screen /dev/ttyUSB0 115200
```
TODO:Continue ssh setup



# Troubleshooting
## ADB
If you cannot see your device on `adb list` or access it make sure you have added your device to `udev` rules.

1. Unplug **Maix-II Dock**
2. In a console run:
```
sudo dmesg -wH
```
3. Plug usb to `USB OTG` port on  Maix-II Dock

You should note the new device in console, something like the following should appear:
```
[ +12.953497] usb 5-1: new high-speed USB device number 4 using xhci_hcd
[  +0.230599] usb 5-1: New USB device found, idVendor=18d1, idProduct=0002, bcdDevice= 4.09
[  +0.000006] usb 5-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  +0.000002] usb 5-1: Manufacturer: Android
[  +0.000002] usb 5-1: SerialNumber: 20080411
````

4. Take note of `idVendor` and

Check your `/etc/udev/rules.d/51-android.rules` (if it doesn't exists create it) and add the following line with your own `idVendor`
```
SUBSYSTEM=="usb", ATTRS{idVendor}=="18d1", MODE="0666"
```

5. Restart udev service with 
```
sudo systemctl restart udev
```
6. Restart adb service with
```
adb kill-server && adb start-server
```
7. Disconnect and reconnect the device again.
8. Try `adb devices` again