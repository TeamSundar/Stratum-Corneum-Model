#!/bin/bash

for i in {4..4}
do	
	if [[ $i -eq 1 ]]
	then
		gmx_mpi grompp -f em_$i.mdp -o em_$i.tpr -c sys.gro -r sys.gro -p topol.top
		gmx_mpi mdrun -v -deffnm em_$i #-gpu_id 1 -ntomp 8
	else
		gmx_mpi grompp -f em_$i.mdp -o em_$i.tpr -c em_$(($i-1)).gro -r em_$(($i-1)).gro -p topol.top
		gmx_mpi mdrun -v -deffnm em_$i  #-gpu_id 1 -ntomp 8
	fi
done

