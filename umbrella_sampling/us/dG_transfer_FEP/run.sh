:'
./mklambdas.sh run.mdp ../../topol.top conf9_last_frame.gro
grep init-lambda lambda_*/grompp.mdp

sed -i 's/toppar\//..\/..\/..\/toppar\//g' lambda*/topol.top
sed -i 's/drug/ESDL/g' lambda*/grompp.mdp
'

for ((i=0;i<=20;i++)); do
	dir=`printf "lambda_%02d" $i`
	cd $dir
	gmx_mpi grompp -c conf.gro -r ../conf9.gro
	gmx_mpi mdrun -v > run.log 
	cd ..
done


gmx_mpi bar -f lambda_*/dhdl.xvg -b 250 -o bar.xvg > out.txt

