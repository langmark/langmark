#!/bin/bash -e

cd "$(dirname "$0")"

case "$1" in

"pre_exec")
    tcc matrix.c -o matrix.bin
;;

"exec")
    /usr/bin/time -f %U ./matrix.bin 2> time.out
;;

"print_exec")
    ./matrix.bin --print > print.out
;;

"version")
    tcc -version > version.out
;;

"clean")
    rm -f matrix.bin time.out print.out version.out
;;

esac
