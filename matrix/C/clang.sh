#!/bin/bash -e

cd "$(dirname "$0")"

case "$1" in

"pre_exec")
    clang matrix.c -std=c11 -O3 -o matrix
;;

"exec")
    /usr/bin/time -f %U ./matrix 2> time.out
;;

"print_exec")
    ./matrix --print > print.out
;;

"version")
    clang --version > version.out
;;

"clean")
    rm matrix
    rm time.out
    rm print.out
    rm version.out
;;

esac
