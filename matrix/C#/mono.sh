#!/bin/bash -e

cd "$(dirname "$0")"

case "$1" in

"pre_exec")
    mcs matrix.cs -out:matrix.exe
;;

"exec")
    /usr/bin/time -f %U mono matrix.exe 2> time.out
;;

"print_exec")
    mono matrix.exe --print > print.out
;;

"version")
    mcs --version > version.out
    mono --version >> version.out
;;

"clean")
    rm matrix.exe
    rm time.out
    rm print.out
    rm version.out
;;

esac
