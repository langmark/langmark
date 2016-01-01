#!/bin/bash -e

cd "$(dirname "$0")"

case "$1" in

"pre_exec")
    ghc -O sort.hs -o sort.bin > /dev/null
;;

"exec")
    /usr/bin/time -f %U ./sort.bin 2> time.out
;;

"print_exec")
    ./sort.bin --print > print.out
;;

"version")
    ghc --version > version.out
;;

"clean")
    rm -f sort.bin sort.o sort.hi time.out print.out version.out
;;

esac
