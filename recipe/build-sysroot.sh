#!/bin/bash

mkdir -p ${PREFIX}/${target_machine}-${ctng_vendor}-linux-gnu/sysroot
pushd ${PREFIX}/${target_machine}-${ctng_vendor}-linux-gnu/sysroot > /dev/null 2>&1
cp -Rf "${SRC_DIR}"/binary/* .
mkdir -p usr/include
cp -Rf "${SRC_DIR}"/binary-tzdata/* usr/
cp -Rf "${SRC_DIR}"/binary-glibc-headers/include/* usr/include/
cp -Rf "${SRC_DIR}"/binary-glibc-devel/* usr/
cp -Rf "${SRC_DIR}"/binary-glibc-common/* .

mv usr/lib/* usr/lib64/
rm -rf usr/lib
ln -s $PWD/lib64 $PWD/lib

ln -s $PWD/usr/lib64 $PWD/usr/lib

popd

if [[ ${ctng_vendor} == "conda_cos6" ]]; then
    ln -s ${PREFIX}/${target_machine}-${ctng_vendor}-linux-gnu ${PREFIX}/${target_machine}-conda-linux-gnu
fi
