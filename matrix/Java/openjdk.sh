#!/bin/bash -e

cd "$(dirname "$0")"

case "$1" in

"pre_exec")
    javac matrix.java
;;

"exec")
    /usr/bin/time -f %U java matrix 2> time.out
;;

"print_exec")
    java matrix --print > print.out
;;

"version")
    javac -version 2> version.out
    java -version 2>> version.out
;;

"clean")
    rm -f matrix.class time.out print.out version.out
;;

esac
