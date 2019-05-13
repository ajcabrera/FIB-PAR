# C compiler
OMPC    = icc # gcc
#OMPC    = gcc
OPT3 	= -g -O3
OPTG0 	= -g -O0
CFLAGS  = -std=c99 # -Wall -std=c99
OPENMP	= -fopenmp
LFLAGS  = -lX11 -L/usr/X11R6/lib 
CINCL    = -I.
CLIBS    = -L.

# Tareador compiler
TAREADORCC = tar-clang
TAREADOR_FLAGS = -tareador-lite -isystem/scratch/nas/1/par0/Soft

TARGETS  = mandel mandeld mandel-tar mandeld-tar mandel-omp mandeld-omp
all: $(TARGETS)

mandel:	mandel-seq.c
	$(OMPC) -o $@ $(OPT3) $(CFLAGS) $^ 

mandeld: mandel-seq.c
	$(OMPC) -D_DISPLAY_ -o $@ $(OPT3) $(CFLAGS) $^ $(LFLAGS)

mandelrow-tar: mandelrow-tar.c
	$(TAREADORCC) $(OPTG0) $(TAREADOR_FLAGS) $(CFLAGS) $(CINCL) $< -o $@ $(CLIBS) 

mandelpoint-tar: mandelpoint-tar.c
	$(TAREADORCC) $(OPTG0) $(TAREADOR_FLAGS) $(CFLAGS) $(CINCL) $< -o $@ $(CLIBS) 

mandeldrow-tar: mandelrow-tar.c
	$(TAREADORCC) -D_DISPLAY_ $(OPTG0) $(TAREADOR_FLAGS) $(CFLAGS) $(CINCL) $< -o $@ $(CLIBS) $(LFLAGS)

mandeldpoint-tar: mandelpoint-tar.c
	$(TAREADORCC) -D_DISPLAY_ $(OPTG0) $(TAREADOR_FLAGS) $(CFLAGS) $(CINCL) $< -o $@ $(CLIBS) $(LFLAGS)

mandel-omp: mandel-omp.c
	$(OMPC) -o $@ $(OPT3) $(CFLAGS) $(OPENMP) $^ 

mandeld-omp: mandel-omp.c
	$(OMPC) -D_DISPLAY_ -o $@ $(OPT3) $(CFLAGS) $(OPENMP) $^ $(LFLAGS)

clean:
	rm -rf $(TARGETS) .tareador_precomputed* logs *.log

ultraclean:
	rm -rf $(TARGETS) .tareador_precomputed* logs *.log *.prv *.pcf *.row dependency_graph* *.times.txt *.sh.o* *.sh.e* elapsed.txt speedup.txt hash_labels.txt TRACE.sym TRACE.mpits set-0 *.ps *.out
