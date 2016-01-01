#!/bin/bash -e

cd "$(dirname "$0")"

case "$1" in

"pre_exec")
    ghc -O matrix.hs > /dev/null
;;

"exec")
    /usr/bin/time -f %U ./matrix 2> time.out
;;

"print_exec")
    ./matrix --print > print.out
;;

"version")
    ghc --version > version.out
;;

"clean")
    rm matrix
    rm matrix.o
    rm matrix.hi
    rm time.out
    rm print.out
    rm version.out
;;

esac
