

for($i=1; $i<=16; $i++){

$cmd="gmx analyze -f traj/conf$i\_pullx.xvg -ac xacf20/conf$i\_xacf_1.xvg -b 21001 -e 41000";
`$cmd`;

$cmd="gmx analyze -f traj/conf$i\_pullx.xvg -ac xacf20/conf$i\_xacf_2.xvg -b 22001 -e 42000";
`$cmd`;

$cmd="gmx analyze -f traj/conf$i\_pullx.xvg -ac xacf20/conf$i\_xacf_3.xvg -b 23001 -e 43000";
`$cmd`;

$cmd="gmx analyze -f traj/conf$i\_pullx.xvg -ac xacf20/conf$i\_xacf_4.xvg -b 24001 -e 45000";
`$cmd`;


}

