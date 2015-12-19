#!/bin/bash -e

cd "$(dirname "$0")"

case "$1" in

"pre_exec")
    tcc sort.c -o sort
;;

"exec")
    /usr/bin/time -f %U ./sort 2> time.out
;;

"print_exec")
    ./sort --print > print.out
;;

"version")
    tcc -version > version.out
;;

"clean")
    rm sort
    rm time.out
    rm print.out
    rm version.out
;;

esac
