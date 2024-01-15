#!/bin/bash

gmx_mpi grompp -f npt_eq.mdp -o npt_eq.tpr -c nvt_eq.gro -r nvt_eq.gro -p topol.top -n index.ndx
gmx_mpi mdrun -v -deffnm npt_eq -gpu_id 1 -ntomp 8
gmx_mpi trjconv -f npt_eq.trr -s nvt_eq.gro -n System.ndx -o npt_eq.xtc -pbc nojump
		

