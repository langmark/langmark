#!/bin/bash -e

cd "$(dirname "$0")"

case "$1" in

"pre_exec")
    vbnc matrix.vb /out:matrix.exe > /dev/null
;;

"exec")
    /usr/bin/time -f %U mono matrix.exe 2> time.out
;;

"print_exec")
    mono matrix.exe --print > print.out
;;

"version")
    vbnc /? | head -n 1 > version.out
    mono --version >> version.out
;;

"clean")
    rm -f matrix.exe time.out print.out version.out
;;

esac
