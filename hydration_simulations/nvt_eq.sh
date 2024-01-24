#!/bin/bash

for i in {1..3}
do	
	if [[ $i -eq 1 ]]
	then
		gmx_mpi grompp -f nvt_eq_$i.mdp -o nvt_eq_$i.tpr -c em.gro -r em.gro -p topol.top
		gmx_mpi mdrun -v -deffnm nvt_eq_$i #-gpu_id 1 -ntomp 8
		gmx_mpi trjconv -f nvt_eq_$i.trr -s nvt_eq_$i.tpr -n System.ndx -o nvt_eq_$i.xtc -pbc mol
		
	else
		gmx_mpi grompp -f nvt_eq_$i.mdp -o nvt_eq_$i.tpr -c nvt_eq_$(($i-1)).gro -r nvt_eq_$(($i-1)).gro -p topol.top
		gmx_mpi mdrun -v -deffnm nvt_eq_$i  #-gpu_id 1 -ntomp 8
		gmx_mpi trjconv -f nvt_eq_$i.trr -s nvt_eq_$i.tpr -n System.ndx -o nvt_eq_$i.xtc -pbc mol
	fi
done

