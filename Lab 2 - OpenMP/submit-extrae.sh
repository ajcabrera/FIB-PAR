#!/bin/csh
# following option makes sure the job will run in the current directory
#$ -cwd
# following option makes sure the job has the same environmnent variables as the submission shell
#$ -V

make $1-omp

setenv OMP_NUM_THREADS 4

setenv LD_PRELOAD ${EXTRAE_HOME}/lib/libomptrace.so
./$1-omp 100000
setenv LD_PRELOAD 

mpi2prv -f TRACE.mpits -o $1-omp.prv -e $1-omp -paraver
rm -rf TRACE.mpits TRACE.sym set-0 >& /dev/null
