#!/bin/bash

gmx_mpi grompp -f pulling.mdp -o pulling.tpr -c npt_eq.gro -r npt_eq.gro -p topol.top -n index.ndx -maxwarn 1
gmx_mpi mdrun -v -deffnm pulling -gpu_id 1 -ntomp 8
gmx_mpi trjconv -f pulling.trr -s npt_eq.gro -n System.ndx -o pulling.xtc -pbc nojump
		

