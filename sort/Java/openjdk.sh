#!/bin/bash -e

cd "$(dirname "$0")"

case "$1" in

"pre_exec")
    javac sort.java
;;

"exec")
    /usr/bin/time -f %U java sort 2> time.out
;;

"print_exec")
    java sort --print > print.out
;;

"version")
    javac -version 2> version.out
    java -version 2>> version.out
;;

"clean")
    rm -f sort.class time.out print.out version.out
;;

esac
