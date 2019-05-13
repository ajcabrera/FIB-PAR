#!/bin/bash
# following option makes sure the job will run in the current directory
#$ -cwd
# following option makes sure the job has the same environmnent variables as the submission shell
#$ -V
# following option to change shell
#$ -S /bin/bash

USAGE="\n USAGE: ./submit-omp.sh prog numthreads cutoff \n
        prog        -> Program name \n
        numthreads  -> Number of threads in parallel execution \n
	cutoff      -> level to stop task generation (optional) \n"

if (test $# -lt 2 || test $# -gt 3)
then
        echo -e $USAGE
        exit 0
fi

PROG=$1
make $PROG

HOST=$(echo $HOSTNAME | cut -f 1 -d'.')

export OMP_NUM_THREADS=$2
export OMP_WAIT_POLICY="passive"

export size=8192
export sort_size=1
export merge_size=1

export LD_PRELOAD=${EXTRAE_HOME}/lib/libomptrace.so

if (test $# -eq 3)
then
export cutoff=$3
./$PROG -n $size -s $sort_size -m $merge_size -c $cutoff > ${PROG}_${OMP_NUM_THREADS}_${cutoff}_${HOST}.times.txt
else
./$PROG -n $size -s $sort_size -m $merge_size > ${PROG}_${OMP_NUM_THREADS}_${HOST}.times.txt
fi

unset LD_PRELOAD
mpi2prv -f TRACE.mpits -o ${PROG}_${OMP_NUM_THREADS}_${HOST}.prv -e $PROG -paraver
rm -rf TRACE.mpits TRACE.sym set-0
