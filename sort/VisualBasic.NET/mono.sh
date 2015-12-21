#!/bin/bash -e

cd "$(dirname "$0")"

case "$1" in

"pre_exec")
    vbnc sort.vb /out:sort.exe > /dev/null
;;

"exec")
    /usr/bin/time -f %U mono sort.exe 2> time.out
;;

"print_exec")
    mono sort.exe --print > print.out
;;

"version")
    vbnc /? | head -n 1 > version.out
    mono --version >> version.out
;;

"clean")
    rm sort.exe
    rm time.out
    rm print.out
    rm version.out
;;

esac
