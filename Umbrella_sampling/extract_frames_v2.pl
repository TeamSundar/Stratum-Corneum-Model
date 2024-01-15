$cmd = "sort  -gk2 pulling_pullx_edited.xvg > pulling_pullx_sorted.xvg";
`$cmd`;


open(REFR,"<pulling_pullx_sorted.xvg");
@ref = <REFR>;
close(REFR);

open(OUT, ">us_frames_v2.dat");

$i = -1.6;
$j = 1.4;

$step = 0.2;

$c=1;

foreach(@ref){
    @a = split(/\t/, $_);

    if ($a[1] >= $i){
        print OUT "$_";
        $cmd="gmx_mpi trjconv -s pulling.tpr -f pulling.trr -o us/conf$c.gro -n System.ndx -b $a[0] -e $a[0]";
        #print "$cmd\n";
        `$cmd`;
        $i = $i + $step;
        $c++;
    }
    if ($i > $j) { last; }
}
close(OUT);


