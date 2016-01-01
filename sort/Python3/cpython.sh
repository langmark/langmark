#!/bin/bash -e

cd "$(dirname "$0")"

case "$1" in

"pre_exec")
;;

"exec")
    /usr/bin/time -f %U python3 sort.py 2> time.out
;;

"print_exec")
    python3 sort.py --print > print.out
;;

"version")
    python3 --version > version.out
;;

"clean")
    rm -f time.out print.out version.out
;;

esac
