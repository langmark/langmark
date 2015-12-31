#!/bin/bash -e

cd "$(dirname "$0")"

case "$1" in

"pre_exec")
    dmd sort.d -O
;;

"exec")
    /usr/bin/time -f %U ./sort 2> time.out
;;

"print_exec")
    ./sort --print > print.out
;;

"version")
    dmd --version > version.out
;;

"clean")
    rm sort
    rm sort.o
    rm time.out
    rm print.out
    rm version.out
;;

esac
