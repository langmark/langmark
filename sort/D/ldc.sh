#!/bin/bash -e

cd "$(dirname "$0")"

case "$1" in

"pre_exec")
    ldc sort.d -O3 -ofsort.bin
;;

"exec")
    /usr/bin/time -f %U ./sort.bin 2> time.out
;;

"print_exec")
    ./sort.bin --print > print.out
;;

"version")
    ldc --version > version.out
;;

"clean")
    rm -f sort.bin sort.o time.out print.out version.out
;;

esac
