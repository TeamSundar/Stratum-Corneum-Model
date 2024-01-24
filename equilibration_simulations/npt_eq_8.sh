#!/bin/bash

for i in {2..5}
do	
	if [[ $i -eq 1 ]]
	then
		gmx_mpi grompp -f npt_eq_8.mdp -o npt_eq_8_$i.tpr -c npt_eq_7.gro -r npt_eq_7.gro -p topol.top
		gmx_mpi mdrun -v -deffnm npt_eq_8_$i #-gpu_id 1 -ntomp 8
		gmx_mpi trjconv -f npt_eq_8_$i.trr -s npt_eq_8_$i.tpr -n System.ndx -o npt_eq_8_$i.xtc -pbc mol
		
	else
		gmx_mpi grompp -f npt_eq_8.mdp -o npt_eq_8_$i.tpr -c npt_eq_8_$(($i-1)).gro -r npt_eq_8_$(($i-1)).gro -p topol.top
		gmx_mpi mdrun -v -deffnm npt_eq_8_$i  #-gpu_id 1 -ntomp 8
		gmx_mpi trjconv -f npt_eq_8_$i.trr -s npt_eq_8_$i.tpr -n System.ndx -o npt_eq_8_$i.xtc -pbc mol
	fi
done

