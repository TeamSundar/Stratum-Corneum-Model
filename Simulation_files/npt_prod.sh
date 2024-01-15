#!/bin/bash

for i in {1..5}
do	
	if [[ $i -eq 1 ]]
	then
		gmx_mpi grompp -f npt_prod.mdp -o npt_prod_$i.tpr -c npt_eq_8_5.gro -r npt_eq_8_5.gro -p topol.top
		gmx_mpi mdrun -v -deffnm npt_prod_$i #-gpu_id 0 -ntomp 8
		gmx_mpi trjconv -f npt_prod_$i.trr -s npt_prod_$i.tpr -n System.ndx -o npt_prod_$i.xtc -pbc mol
		
	else
		gmx_mpi grompp -f npt_prod.mdp -o npt_prod_$i.tpr -c npt_prod_$(($i-1)).gro -r npt_prod_$(($i-1)).gro -p topol.top
		gmx_mpi mdrun -v -deffnm npt_prod_$i  #-gpu_id 0 -ntomp 8
		gmx_mpi trjconv -f npt_prod_$i.trr -s npt_prod_$i.tpr -n System.ndx -o npt_prod_$i.xtc -pbc mol
	fi
done

