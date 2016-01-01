#!/bin/bash -e

cd "$(dirname "$0")"

case "$1" in

"pre_exec")
    mcs sort.cs -out:sort.exe
;;

"exec")
    /usr/bin/time -f %U mono sort.exe 2> time.out
;;

"print_exec")
    mono sort.exe --print > print.out
;;

"version")
    mcs --version > version.out
    mono --version >> version.out
;;

"clean")
    rm -f sort.exe time.out print.out version.out
;;

esac
