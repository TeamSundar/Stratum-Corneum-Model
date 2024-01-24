#!/bin/bash

gmx_mpi grompp -f em.mdp -o em.tpr -c sys.gro -r sys.gro -p topol.top
gmx_mpi mdrun -v -deffnm em -gpu_id 1 -ntomp 8



