#/bin/bash
specconfig=/home/alf/spec2006/CPU2006_Install/config
specbench=/home/alf/spec2006/CPU2006_Install/benchspec
INT="
400.perlbench
401.bzip2
403.gcc
429.mcf
445.gobmk
456.hmmer
458.sjeng
462.libquantum
464.h264ref
471.omnetpp
473.astar
483.xalancbmk
999.specrand
"
FP="
 410.bwaves
 416.gamess
 433.milc
 434.zeusmp
 435.gromacs
 436.cactusADM
 437.leslie3d
 444.namd
 447.dealII
 450.soplex
 453.povray
 454.calculix
 459.GemsFDTD
 465.tonto
 470.lbm
 481.wrf
 482.sphinx3
 998.specrand
	 "
cd $specconfig
source ../shrc

#find ${specbench} -name exe -exec rm -rfv {} \;
#find ${specbench} -name run -exec rm -rfv {} \;

runspec -c pmc-950-O3.cfg --action setup all

echo $INT
for case in $INT
do
	case=${case%.*}
	echo $case
	runspec -c pmc-950-O3.cfg -i test -n 1 --noreportable $case &
	sleep 2
	ps -ef | grep CPU_O3 | awk '{print $2}' | xargs kill -9
done

for i in 1 2 3 4 5
do
	echo $i
	ps -ef | grep CPU_O3 | awk '{print $2}' | xargs kill -9
done


echo $FP
for case in $FP
do
	case=${case%.*}
	echo $case
	runspec -c pmc-950-O3.cfg -i test -n 1 --noreportable $case &
	sleep 1
	ps -ef | grep CPU_O3 | awk '{print $2}' | xargs kill -9
done
	
sleep 2
for i in 1 2 3 4 5
do
	echo $i
	ps -ef | grep CPU_O3 | awk '{print $2}' | xargs kill -9
done
sleep 2
