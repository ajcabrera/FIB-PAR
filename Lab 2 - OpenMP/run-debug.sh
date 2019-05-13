#!/bin/bash

USAGE="\n USAGE: run-omp.sh PROG \n
        PROG       -> program name (e.g. pi-vX)\n"

if (test $# -lt 1 || test $# -gt 2)
then
        echo -e $USAGE
        exit 0
fi

export OMP_NUM_THREADS=4

make $1-debug

#/usr/bin/time ./$1-debug 32
./$1-debug 32
