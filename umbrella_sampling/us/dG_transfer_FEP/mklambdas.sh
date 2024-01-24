#!/bin/sh

if [ $# -lt 3 ]; then
    echo "Usage: mklambdas.sh grompp.mdp topol.top conf.gro."
    echo
    echo "Makes directories with given mdp file, topology, and configuration"
    echo "Replaces \$LAMBDA\$ in mdp file with current lambda point"
    exit 1
fi

Nlambdas=`cat $1 | grep fep-lambdas | wc -w`
Nlambdas=`expr $Nlambdas - 2`

i=0
while [ $i -lt $Nlambdas ]
do
    newdir=`printf "lambda_%02d" $i`
    echo "Making directory $newdir, and populating it"
    mkdir -p $newdir
    # now do the substitution
    sed "s/\\\$LAMBDA\\\$/${i}/" $1 > $newdir/grompp.mdp
    cp $2 $newdir/topol.top
    cp $3 $newdir/conf.gro
    i=`expr $i + 1`
done

