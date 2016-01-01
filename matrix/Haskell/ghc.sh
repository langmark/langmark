#!/bin/bash -e

cd "$(dirname "$0")"

case "$1" in

"pre_exec")
    ghc -O matrix.hs -o matrix.bin > /dev/null
;;

"exec")
    /usr/bin/time -f %U ./matrix.bin 2> time.out
;;

"print_exec")
    ./matrix.bin --print > print.out
;;

"version")
    ghc --version > version.out
;;

"clean")
    rm -f matrix.bin matrix.o matrix.hi time.out print.out version.out
;;

esac
