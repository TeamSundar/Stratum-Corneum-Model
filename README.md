
### Model building: 
The 3D strcutures of ceramide NP, ceramide AP, lignoceric acid and water genertaed using ‘3D Builder’ of Schrodinger Maestro are in the folder model_building/initial_structures. 
The input file of 'Packmol' is model_building/pack_model.inp.
```
packmol < pack_model.inp 
```
The output structure of Packmol is model_building/sc_box_070070080_2jun22.pdb.
sc_box_070070080_2jun22.pdb was converted to .gro fromat and the residues were renumbered.
```
gmx editconf -f sc_box_070070080_2jun22.pdb -o sc_box_070070080_2jun22.gro -bt triclinic -box 7 7 8
```
model_building/sc_box_renumbered.gro was the starting structure for MD_simulation.

### Model equilibration
The CHARMM36 parameter files of the molecules are in charmm36_parameters.
The shell scripts and .mdp files used for equilibrating the model are in model_equilibration. The scripts were run in the following order.
```
./em.sh
./nvt_eq.sh
./npt_eq.sh
./npt_eq_8.sh
./npt_prod.sh
```
The initial structure of production simulation is npt_eq_8_5.pdb.

### Calculation of system properties
Lengths of the simulation box in XY and Z dimensions for calculation of periodicity and area per ceramide was obtained using the following command.
```
gmx energy -f npt_prod_1-3.edr -o Box_XYZ.xvg
```
The densities of system coomponents along Z-axis was calculated using the following command.
```
gmx density -f npt_prod_1-3.trr -s npt_prod_1.tpr -o densities/all_1-3.xvg -center -relative -symm -ng 6 -sl 75
```
The angle between the fatty acid tails and sphingosine tails of ceramides were calculated using system_properties/angle_ceramide_ext.ipynb


Model_Structure_npt_eq_8_5.pdb: the PDB strcuture of the built model after equilibration.
