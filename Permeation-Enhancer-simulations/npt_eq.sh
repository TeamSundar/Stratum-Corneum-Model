#!/bin/bash

for i in {1..2}
do	
	if [[ $i -eq 1 ]]
	then
		gmx_mpi grompp -f npt_eq_$i.mdp -o npt_eq_$i.tpr -c nvt_eq_3.gro -r nvt_eq_3.gro -p topol.top
		gmx_mpi mdrun -v -deffnm npt_eq_$i #-gpu_id 0 -ntomp 8
		gmx_mpi trjconv -f npt_eq_$i.trr -s npt_eq_$i.tpr -n System.ndx -o npt_eq_$i.xtc -pbc mol
		
	else
		gmx_mpi grompp -f npt_eq_$i.mdp -o npt_eq_$i.tpr -c npt_eq_$(($i-1)).gro -r npt_eq_$(($i-1)).gro -p topol.top
		gmx_mpi mdrun -v -deffnm npt_eq_$i  #-gpu_id 0 -ntomp 8
		gmx_mpi trjconv -f npt_eq_$i.trr -s npt_eq_$i.tpr -n System.ndx -o npt_eq_$i.xtc -pbc mol
	fi
done

