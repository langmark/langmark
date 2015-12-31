#!/bin/bash -e

cd "$(dirname "$0")"

case "$1" in

"pre_exec")
    ldc sort.d -O3
;;

"exec")
    /usr/bin/time -f %U ./sort 2> time.out
;;

"print_exec")
    ./sort --print > print.out
;;

"version")
    ldc --version > version.out
;;

"clean")
    rm sort
    rm sort.o
    rm time.out
    rm print.out
    rm version.out
;;

esac
