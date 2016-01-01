#!/bin/bash -e

cd "$(dirname "$0")"

case "$1" in

"pre_exec")
    crystal build sort.cr
;;

"exec")
    /usr/bin/time -f %U ./sort 2> time.out
;;

"print_exec")
    ./sort --print > print.out
;;

"version")
    crystal --version > version.out
;;

"clean")
    rm sort
    rm -rf .crystal
    rm time.out
    rm print.out
    rm version.out
;;

esac
