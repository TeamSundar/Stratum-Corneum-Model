#!/bin/bash

gmx_mpi grompp -f nvt_eq.mdp -o nvt_eq.tpr -c em.gro -r em.gro -p topol.top -n index.ndx
gmx_mpi mdrun -v -deffnm nvt_eq  -gpu_id 1 -ntomp 8
gmx_mpi trjconv -f nvt_eq.trr -s em.tpr -n System.ndx -o nvt_eq.xtc -pbc nojump
		

