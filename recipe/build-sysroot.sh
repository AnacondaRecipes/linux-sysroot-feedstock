#!/bin/bash

mkdir -p ${PREFIX}/${target_machine}-${ctng_vendor}-linux-gnu/sysroot
pushd ${PREFIX}/${target_machine}-${ctng_vendor}-linux-gnu/sysroot > /dev/null 2>&1
cp -Rf "${SRC_DIR}"/binary/* .
mkdir -p usr/include
cp -Rf "${SRC_DIR}"/binary-tzdata/* usr/
cp -Rf "${SRC_DIR}"/binary-glibc-headers/include/* usr/include/
cp -Rf "${SRC_DIR}"/binary-glibc-devel/* usr/
cp -Rf "${SRC_DIR}"/binary-glibc-common/* .

mkdir -p usr/lib
mkdir -p usr/lib64
mv usr/lib/* usr/lib64/
rm -rf usr/lib
ln -s $PWD/usr/lib64 $PWD/usr/lib

if [ -d "lib" ]; then
    # Only move libs if they don't already exists to avoid errors.
    for lib_file in lib/*; do
        if [ ! -f lib64/$(basename -- "${lib_file}") ]; then
            mv ${lib_file} lib64/
        fi
    done
    rm -rf lib
fi

if [[ "$target_machine" == "s390x" ]]; then
   rm -rf $PWD/lib64/ld64.so.*
   ln -s $PWD/lib64/ld-* $PWD/lib64/ld64.so*
fi

ln -s $PWD/lib64 $PWD/lib

cp "${SRC_DIR}"/binary-freebl/usr/lib64/libfreebl3.so ${PWD}/usr/lib64/.

popd
