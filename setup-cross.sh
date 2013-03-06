
#!/bin/sh -e



CROSS_BASE=/opt/freescale/usr/local/gcc-4.4.4-glibc-2.11.1-multilib-1.0/arm-fsl-linux-gnueabi
CROSS_INCLUDE=${CROSS_BASE}/arm-fsl-linux-gnueabi/multi-libs/usr/include/
#/opt/freescale/usr/local/gcc-4.4.4-glibc-2.11.1-multilib-1.0/arm-fsl-linux-gnueabi
CROSS_CC=${CROSS_BASE}/bin/arm-fsl-linux-gnueabi-gcc
#@echo Using GCC toolchain for Freescale i.MX28: $(CROSS_CC)
#CC= $(CROSS_CC) -I$(CROSS_INCLUDE)
#LD_FLAGS= -L${CROSS_BASE}/multi-libs/armv5te/usr/lib
PREFIX_BIN=$CROSS_BASE/bin/arm-fsl-linux-gnueabi



#export CSTOOLS=/opt/code-sourcery/arm-2009q1
export CSTOOLS=$CROSS_BASE/bin
ROOTFS_USR_LIB=/opt2/freescale/ltib/ltib/rootfs/usr/lib
ROOTFS_USR_INC=/opt2/freescale/ltib/ltib/rootfs/usr/include

# cross library directory, should include stdc++:
export CSTOOLS_LIB=/opt/ltib/rootfs/lib
export CSTOOLS_USR_LIB=/opt/ltib/rootfs/usr/lib

# libc & system headers:
export CSTOOLS_INC=${CROSS_BASE}/arm-fsl-linux-gnueabi/multi-libs/usr/include/
#export CSTOOLS_LIB=${CROSS_BASE}/multi-libs/armv5te/usr/lib

export TARGET_ARCH="-march=armv5te" 
#"-march=armv7-a" # must be at least armv5te
#export TARGET_TUNE="-mtune=cortex-a8 -mfpu=neon -mfloat-abi=softfp -mthumb-interwork -mno-thumb" # optional
export TARGET_TUNE="-mtune=arm926ej-s -mfloat-abi=soft -mno-thumb-interwork" # optional


export TOOL_PREFIX=$PREFIX_BIN
#export CXX=$TOOL_PREFIX-g++
#export AR=$TOOL_PREFIX-ar
#export RANLIB=$TOOL_PREFIX-ranlib
#export CC=$TOOL_PREFIX-gcc
#export LD=$TOOL_PREFIX-ld

export CCFLAGS="-march=armv5te -mtune=arm926ej-s -mno-thumb-interwork -lstdc++"

# -march=armv5te -mtune=arm926ej-s -mfloat-abi=softfp

export ARM_TARGET_LIB=$CTOOLS_LIB

export GYP_DEFINES="armv7=0" # if your target does not do ARM v7 instructions then =0

export CPP="${PREFIX_BIN}-gcc -E"
export STRIP="${PREFIX_BIN}-strip"
export OBJCOPY="${PREFIX_BIN}-objcopy"
export AR="${PREFIX_BIN}-ar"
export F77="${PREFIX_BIN}-g77 ${TARGET_ARCH} ${TARGET_TUNE}"
unset LIBC
export RANLIB="${PREFIX_BIN}-ranlib"
#export LD="${PREFIX_BIN}-ld"  # for some reason this newer ld for arm does not have -rpath option (or at least they aren't taking) so go to g++
export LD="${PREFIX_BIN}-g++"
export LDFLAGS="-L${CSTOOLS_USR_LIB} -L${CSTOOLS_LIB} -Wl,-rpath-link,${CSTOOLS_LIB} -Wl,-O1 -Wl,--hash-style=gnu"
export MAKE="make"
export CXXFLAGS="-isystem${CSTOOLS_INC} -fexpensive-optimizations -frename-registers -fomit-frame-pointer -O0 -ggdb3 -fpermissive -fvisibility-inlines-hidden"
export LANG="en_US.UTF-8"
export HOME="/home/ed"
export CCLD="${PREFIX_BIN}-gcc ${TARGET_ARCH} ${TARGET_TUNE}"
export PATH="${CSTOOLS}/bin:/opt/code-sourcery/arm-2009q1/bin/:${HOME}/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games"
export CFLAGS="-isystem${CSTOOLS_INC} -fexpensive-optimizations -frename-registers -fomit-frame-pointer -O0 -ggdb3"
export OBJDUMP="arm-none-linux-gnueabi-objdump"
export CPPFLAGS="-isystem${CSTOOLS_INC}"
export CC="${PREFIX_BIN}-gcc ${TARGET_ARCH} ${TARGET_TUNE}"
#export TITOOLSDIR="/mnt/data/overo-oe/ti"
export TERM="screen"
export SHELL="/bin/bash"
export CXX="${PREFIX_BIN}-g++ ${TARGET_ARCH} ${TARGET_TUNE}"
export NM="${PREFIX_BIN}-nm"
export AS="${PREFIX_BIN}-as"
#export LINK.host="ld -m elf_i386"
# Configure node.js for cross-compile

./configure --debug --without-snapshot --dest-cpu=arm --gdb --shared-zlib --shared-zlib-libpath=${ROOTFS_USR_LIB} --shared-zlib-includes=${ROOTFS_USR_INC} --without-ssl --no-ssl2 # --shared-v8

bash --norc

# or run make / make -j 8 / etc...
