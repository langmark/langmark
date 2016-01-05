#!/bin/bash -e

cd "$(dirname "$0")"

case "$1" in

"pre_exec")
    clang++ -stdlib=libc++ sort.cpp -nodefaultlibs -lc++ -lc++abi -lm -lc -lgcc_s -lgcc -O3 -o sort.bin
;;

"exec")
    /usr/bin/time -f %U ./sort.bin 2> time.out
;;

"print_exec")
    ./sort.bin --print > print.out
;;

"version")
    clang++ --version > version.out
;;

"clean")
    rm -f sort.bin time.out print.out version.out
;;

esac
