#!/bin/bash -e

cd "$(dirname "$0")"

case "$1" in

"pre_exec")
    ghc -O sort.hs > /dev/null
;;

"exec")
    /usr/bin/time -f %U ./sort 2> time.out
;;

"print_exec")
    ./sort --print > print.out
;;

"version")
    ghc --version > version.out
;;

"clean")
    rm sort
    rm sort.o
    rm sort.hi
    rm time.out
    rm print.out
    rm version.out
;;

esac
