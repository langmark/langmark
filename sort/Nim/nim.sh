#!/bin/bash -e

cd "$(dirname "$0")"

case "$1" in

"pre_exec")
    nim c -d:release sort.nim 2> /dev/null > /dev/null
    mv sort sort.bin
;;

"exec")
    /usr/bin/time -f %U ./sort.bin 2> time.out
;;

"print_exec")
    ./sort.bin --print > print.out
;;

"version")
    nim --version 2> version.out
;;

"clean")
    rm -f sort.bin sort time.out print.out version.out
    rm -fr nimcache
;;

esac
