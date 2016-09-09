#!/bin/bash -e

# Build
echo "Compiling..."
cd ${OPENSSL_DIR}
perl -pi -e 's/install: all install_docs install_sw/install: install_docs install_sw/g' Makefile.org
./config shared -no-ssl2 -no-ssl3 -no-comp -no-hw -no-engine --openssldir=/usr/local/ssl/$ANDROID_API > ../${OPENSSL_BUILD_LOG}
make depend >> ../${OPENSSL_BUILD_LOG}
make all >> ../${OPENSSL_BUILD_LOG}

# Installing
echo "Installing..."
sudo -E make install CC=$ANDROID_TOOLCHAIN/prebuild/linux-x86_64/bin/arm-linux-androideabi-gcc RANLIB=$ANDROID_TOOLCHAIN/prebuild/linux-x86_64/bin/arm-linux-androideabi-ranlib  >> ../${OPENSSL_BUILD_LOG}
