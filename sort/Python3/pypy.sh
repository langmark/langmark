#!/bin/bash -e

cd "$(dirname "$0")"

case "$1" in

"pre_exec")
;;

"exec")
    /usr/bin/time -f %U pypy3 sort.py 2> time.out
;;

"print_exec")
    pypy3 sort.py --print > print.out
;;

"version")
    pypy3 --version 2> version.out
;;

"clean")
    rm time.out
    rm print.out
    rm version.out
;;

esac
