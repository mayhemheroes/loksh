#!/bin/sh -xe

meson --buildtype=release --prefix=/usr build
DESTDIR=../dst ninja -C build install
[ "`./dst/usr/bin/ksh -c 'echo $((1337 * 2))'`" -ne 2674 ] && exit 1
[ "`./dst/usr/bin/ksh -c 'seq 1337 | sort -rn | head -n 1'`" -ne 1337 ] && exit 1
CC=clang meson --buildtype=release build-clang
ninja -C build-clang

if [ "`readlink /proc/$$/exe`" != /tmp/ksh ]
then
	cp -f dst/usr/bin/ksh /tmp/
	rm -rf build build-clang dst
	exec /tmp/ksh -xe $0
fi
