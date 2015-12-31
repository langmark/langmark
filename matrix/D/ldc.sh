#!/bin/bash -e

cd "$(dirname "$0")"

case "$1" in

"pre_exec")
    ldc matrix.d -O3
;;

"exec")
    /usr/bin/time -f %U ./matrix 2> time.out
;;

"print_exec")
    ./matrix --print > print.out
;;

"version")
    ldc --version > version.out
;;

"clean")
    rm matrix
    rm matrix.o
    rm time.out
    rm print.out
    rm version.out
;;

esac
