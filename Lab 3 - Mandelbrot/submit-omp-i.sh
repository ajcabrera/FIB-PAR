#!/bin/bash
# following option makes sure the job will run in the current directory
#$ -cwd
# following option makes sure the job has the same environmnent variables as the submission shell
#$ -V
# following option to change shell
#$ -S /bin/bash

USAGE="\n USAGE: ./submit-omp.sh prog numthreads \n
        prog        -> Program name\n
        numthreads  -> Number of threads in parallel execution\n"

if (test $# -lt 2 || test $# -gt 2)
then
        echo -e $USAGE
        exit 0
fi

PROG=$1
make $PROG

HOST=$(echo $HOSTNAME | cut -f 1 -d'.')

export OMP_NUM_THREADS=$2

export LD_PRELOAD=${EXTRAE_HOME}/lib/libomptrace.so
./$PROG -i 10000
unset LD_PRELOAD

mpi2prv -f TRACE.mpits -o ${PROG}-${OMP_NUM_THREADS}-${HOST}.prv -e $PROG -paraver
rm -rf  TRACE.mpits set-0 >& /dev/null
