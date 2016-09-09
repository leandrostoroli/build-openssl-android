#!/bin/bash -e

OPENSSL_VERSION=${1:-"1.0.1j"}
OPENSSL_TARBALL=openssl-${OPENSSL_VERSION}.tar.gz
OPENSSL_DIR=openssl-${OPENSSL_VERSION}
OPENSSL_BUILD_LOG=openssl-${OPENSSL_VERSION}.log

# Download openssl source
if [ ! -e ${OPENSSL_TARBALL} ]; then
	echo "Downloading openssl-${OPENSSL_VERSION}.tar.gz..."
	curl -# -O https://www.openssl.org/source/${OPENSSL_TARBALL}
fi

# Verify the source file
if [ ! -e ${OPENSSL_TARBALL}.sha1 ]; then
	echo -n "Verifying...	"
	curl -o ${OPENSSL_TARBALL}.sha1 -s https://www.openssl.org/source/${OPENSSL_TARBALL}.sha1
	CHECKSUM=`cat ${OPENSSL_TARBALL}.sha1`
	ACTUAL=`shasum ${OPENSSL_TARBALL} | awk '{ print \$1 }'`
	if [ "x$ACTUAL" == "x$CHECKSUM" ]; then
		echo "OK"
	else
		echo "FAIL"
		rm -f ${OPENSSL_TARBALL}
		rm -f ${OPENSSL_TARBALL}.sha1
		return 1
	fi
fi

# Untar the file
if [ ! -e ${OPENSSL_DIR} ]; then
	tar zxf ${OPENSSL_TARBALL}
fi
