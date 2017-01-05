#/bin/bash
spec=/home/cpu/spec2006/CPU2006_Install
specbenchspec=${spec}/benchspec/
lenbenchspec=`expr length $specbenchspec`
cur=`pwd`
specFP=${spec}/benchspec/CPU2006/
lenFP=`expr length $specFP`

specINT=${spec}/benchspec/CPU2006/
lenINT=`expr length $specINT`

head=/home/cpu/spec2006/CPU2006_Install/benchspec/CPU2006/
tail=/run/run_base_test_CPU_O3.0000
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

funCpCmds(){
	echo "specFP"  $specFP
	echo "specINT"  $specINT
	cd $cur
	if [ -d "casecmds" ];then
		echo " ---> rm casecmds"
		rm -rf casecmds
	fi
	echo " ---> mkdir casecmds"
	mkdir casecmds
	cd $cur/casecmds

	echo -e "\t\tint cmds\n" > int.cmds
	for case in $INT
	do
		mkdir -p CPU2006/${case}${tail}
		cp ${head}${case}${tail}/speccmds.cmd CPU2006/${case}${tail}
		echo $case >> int.cmds
		sed -n '2,$p' ${head}${case}${tail}/speccmds.cmd >> int.cmds
		sed -i '3,$d' ${head}${case}${tail}/speccmds.cmd 
		echo "" >> int.cmds
	done

	echo -e "\t\tfp cmds\n" > fp.cmds
	for case in $FP
	do
		mkdir -p CPU2006/${case}${tail}
		cp ${head}${case}${tail}/speccmds.cmd CPU2006/${case}${tail}
		echo $case >> fp.cmds
		sed -n '2,$p' ${head}${case}${tail}/speccmds.cmd >> fp.cmds
		sed -i '3,$d' ${head}${case}${tail}/speccmds.cmd 
		echo "" >> fp.cmds
	done
}

funCpCmds
