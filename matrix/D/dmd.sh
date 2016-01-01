#!/bin/bash -e

cd "$(dirname "$0")"

case "$1" in

"pre_exec")
    dmd matrix.d -O -ofmatrix.bin
;;

"exec")
    /usr/bin/time -f %U ./matrix.bin 2> time.out
;;

"print_exec")
    ./matrix.bin --print > print.out
;;

"version")
    dmd --version > version.out
;;

"clean")
    rm -f matrix.bin matrix.o time.out print.out version.out
;;

esac
