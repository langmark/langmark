#!/bin/bash -e

cd "$(dirname "$0")"

case "$1" in

"pre_exec")
;;

"exec")
    /usr/bin/time -f %U node sort.js 2> time.out
;;

"print_exec")
    node sort.js --print > print.out
;;

"version")
    node --version > version.out
;;

"clean")
    rm -f time.out print.out version.out
;;

esac
