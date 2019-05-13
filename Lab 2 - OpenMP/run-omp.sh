#!/bin/bash

USAGE="\n USAGE: run-omp.sh PROG \n
        PROG       -> program name (e.g. pi-vX)\n"

if (test $# -lt 1 || test $# -gt 2)
then
        echo -e $USAGE
        exit 0
fi

export OMP_NUM_THREADS=4

make $1-omp

#/usr/bin/time ./$1-omp 100000000
./$1-omp 100000000
