# Maix Toolchain
#export MAIX_TOOLCHAIN="/opt/maix_toolchain"
export MAIX_TOOLCHAIN_SUNXI=$MAIX_TOOLCHAIN/toolchain-sunxi-musl/toolchain
export MAIX_BIN=$MAIX_TOOLCHAIN_SUNXI/bin

# C env
export CC="$MAIX_BIN/arm-openwrt-linux-muslgnueabi-gcc"
export CCSHARED="$MAIX_BIN/arm-openwrt-linux-muslgnueabi-gcc -fpic"
export CXX="$MAIX_BIN/arm-openwrt-linux-muslgnueabi-g++"
export LD="$MAIX_BIN/arm-openwrt-linux-muslgnueabi-gcc"
export LDSHARED="$MAIX_BIN/arm-openwrt-linux-muslgnueabi-gcc -shared"
export CFLAGS="-Os -pipe -march=armv7-a -mtune=cortex-a7 -mfpu=neon -fno-caller-saves -Wno-unused-result -mfloat-abi=hard  -Wformat -Werror=format-security -fdiagnostics-color=auto -fstack-protector -D_FORTIFY_SOURCE=1 -Wl,-z,now -Wl,-z,relro"
export CPPFLAGS="-I$MAIX_TOOLCHAIN/usr/include -I$MAIX_TOOLCHAIN_SUNXI/usr/include -I$MAIX_TOOLCHAIN_SUNXI/include -I$MAIX_TOOLCHAIN_SUNXI/include/fortify -I$MAIX_TOOLCHAIN/usr/include/python3.8"
export LDFLAGS="-L$MAIX_TOOLCHAIN/usr/lib -L$MAIX_TOOLCHAIN/lib -L$MAIX_TOOLCHAIN_SUNXI/usr/lib -L$MAIX_TOOLCHAIN_SUNXI/lib -znow -zrelro -lpython3.8"

# Make Flag
export MAKEFLAGS="-j$(nproc)"