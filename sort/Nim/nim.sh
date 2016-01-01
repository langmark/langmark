#!/bin/bash -e

cd "$(dirname "$0")"

case "$1" in

"pre_exec")
    nim c -d:release sort.nim 2> /dev/null > /dev/null
;;

"exec")
    /usr/bin/time -f %U ./sort 2> time.out
;;

"print_exec")
    ./sort --print > print.out
;;

"version")
    nim --version 2> version.out
;;

"clean")
    rm sort
    rm -r nimcache
    rm time.out
    rm print.out
    rm version.out
;;

esac
