#!/bin/bash -e

cd "$(dirname "$0")"

case "$1" in

"pre_exec")
    gcc sort.c -std=c11 -O3 -o sort
;;

"exec")
    /usr/bin/time -f %U ./sort 2> time.out
;;

"print_exec")
    ./sort --print > print.out
;;

"version")
    gcc --version > version.out
;;

"clean")
    rm sort
    rm time.out
    rm print.out
    rm version.out
;;

esac
