#!/bin/csh
# following option makes sure the job will run in the current directory
#$ -cwd
# following option makes sure the job has the same environmnent variables as the submission shell
#$ -V

setenv SEQ  multisort
setenv PROG multisort-omp

# Make sure that all binaries exist
make $SEQ
make $PROG

setenv OMP_NUM_THREADS 4
setenv OMP_WAIT_POLICY "passive"

setenv size 32768 
setenv sort_size 1
setenv merge_size 1
set depth_list = "0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15"

set i = 1

set out = $PROG-$OMP_NUM_THREADS-cutoff.txt
rm -rf $out
rm -rf ./elapsed.txt
foreach depth ( $depth_list )
	echo $depth >> $out
	./$PROG -n $size -s $sort_size -m $merge_size -c $depth >> $out
        set result = `cat $out | tail -n 4  | grep "Multisort execution time"| cut -d':' -f 2`
	echo $i >> ./elapsed.txt
	echo $result >> ./elapsed.txt
	set i = `echo $i + 1 | bc -l`
end

set i = 1
rm -rf ./hash_labels.txt
foreach depth ( $depth_list )
	echo "hash_label at " $i " : " $depth >> ./hash_labels.txt
	set i = `echo $i + 1 | bc -l`
end

jgraph -P cutoff-omp.jgr > $PROG-$OMP_NUM_THREADS-cutoff.ps
set usuario=`whoami`
set fecha=`date`
sed -i -e "s/UUU/$usuario/g" $PROG-$OMP_NUM_THREADS-cutoff.ps
sed -i -e "s/FFF/$fecha/g" $PROG-$OMP_NUM_THREADS-cutoff.ps
rm -rf ./hash_labels.txt
