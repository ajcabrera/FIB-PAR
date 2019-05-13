#!/bin/csh
# following option makes sure the job will run in the current directory
#$ -cwd
# following option makes sure the job has the same environmnent variables as the submission shell
#$ -V

make $1-omp

setenv OMP_NUM_THREADS 4

./$1-omp 100000000
