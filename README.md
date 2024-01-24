
### Model building: 
The 3D strcutures of ceramide NP, ceramide AP, lignoceric acid and water genertaed using ‘3D Builder’ of Schrodinger Maestro are in the folder model_building/initial_structures. 
The input file of 'Packmol' is model_building/pack_model.inp.
```
packmol < pack_model.inp 
```
The output structure of Packmol is /model_building/sc_box_070070080_2jun22.pdb.
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

For calculating NSLD plots using SIMtoEXP, the number densities of C, H, O and N atoms along z-axis was calculated using the following command.
```
gmx density -f npt_prod_1-3.trr -s npt_prod_1.tpr -o densities/chon_1-3.xvg -n indices/chon.ndx -center -sl 400 -ng 4 -dens number
``` 
The input files used in SIMtoEXP to generate the NSLD plots for the simulated models are system_properties/extended_ceramide.sim and system_properties/hairpin_ceramide.sim.

The experimental NSLD plots from Groen et al (Figure 4A in https://doi.org/10.1016/j.bpj.2011.02.001) and Schmitt et al (Figure 3A (dashed line) in https://doi.org/10.1021/acs.langmuir.7b01848) were read using the MATLAB code at https://www.mathworks.com/matlabcentral/fileexchange/7173-grabit (Accessed January 24, 2024).

The NSLD values and the python script used for plotting Figure 9 in the manuscript are  system_properties/NSLD.csv and system_properties/nsld.ipynb
