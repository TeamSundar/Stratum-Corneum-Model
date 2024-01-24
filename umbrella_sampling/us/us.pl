
$cnt = 1;
$cntmax = 16;
while($cnt<=$cntmax){

	$cmd = "gmx_mpi grompp -f us.mdp -o traj/conf$cnt.tpr -c conf$cnt.gro -r conf$cnt.gro  -n ../index.ndx -p ../topol.top -maxwarn 1";
	`$cmd`;
	$cmd = "gmx_mpi mdrun -v -deffnm traj/conf$cnt  -gpu_id 1 -ntomp 8";
	`$cmd`;
	
	$cnt++;
}
	
