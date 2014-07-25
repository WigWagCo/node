
#!/bin/sh -e


if [ "$#" -lt 1 ]; then 
    echo "Need to pass a cross compile setup."
    exit 1
fi

source "$1"

echo "Sanity check:"
echo "CC=$CC"
echo

#--shared-zlib --shared-zlib-libpath=${ROOTFS_USR_LIB} --shared-zlib-includes=${ROOTFS_USR_INC} --debug
./configure  --without-snapshot --dest-cpu=${NODE_DEST_CPU} --gdb  --without-ssl --no-ssl2 # --shared-v8
bash --norc

# or run make / make -j 8 / etc...
