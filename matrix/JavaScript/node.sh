#!/bin/bash -e

cd "$(dirname "$0")"

case "$1" in

"pre_exec")
;;

"exec")
    /usr/bin/time -f %U node matrix.js 2> time.out
;;

"print_exec")
    node matrix.js --print > print.out
;;

"version")
    node --version > version.out
;;

"clean")
    rm time.out
    rm print.out
    rm version.out
;;

esac
