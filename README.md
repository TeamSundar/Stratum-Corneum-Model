## Experimental evidence-based atomistic model for stratum corneum lipid matrix for skin permeation studies

### Model building: 
The 3D structures of ceramide NP, ceramide AP, lignoceric acid and water generated using ‘3D Builder’ of Schrodinger Maestro 2021.3 are in the folder model_building/initial_structures. <br>
The input file of Packmol v18.169 is [model_building/pack_model.inp](model_building/pack_model.inp).
```
packmol < pack_model.inp 
```
The output structure of Packmol is [model_building/sc_box_070070080_2jun22.pdb](model_building/sc_box_070070080_2jun22.pdb). <br>
[sc_box_070070080_2jun22.pdb](model_building/sc_box_070070080_2jun22.pdb) was converted to .gro fromat and the residues were renumbered.
```
gmx editconf -f sc_box_070070080_2jun22.pdb -o sc_box_070070080_2jun22.gro -bt triclinic -box 7 7 8
```
[model_building/sc_box_renumbered.gro](model_building/sc_box_renumbered.gro) was the starting structure for MD_simulation.

### Model equilibration
The CHARMM36 parameter files of the molecules are in [charmm36_parameters](charmm36_parameters). <br>
The shell scripts and .mdp files used for equilibrating the model are in [model_equilibration](model_equilibration). The scripts were run in the following order.
```
./em.sh
./nvt_eq.sh
./npt_eq.sh
./npt_eq_8.sh
./npt_prod.sh
```
The initial structure of production simulation is [Model_Structure_npt_eq_8_5.pdb](Model_Structure_npt_eq_8_5.pdb).

### Calculation of system properties
Lengths of the simulation box in XY and Z dimensions for calculation of periodicity and area per ceramide was obtained using the following command.
```
gmx energy -f npt_prod_1-3.edr -o Box_XYZ.xvg
```
The densities of system coomponents along Z-axis was calculated using the following command.
```
gmx density -f npt_prod_1-3.trr -s npt_prod_1.tpr -o densities/all_1-3.xvg -center -relative -symm -ng 6 -sl 75
```
The angle between the fatty acid tails and sphingosine tails of ceramides were calculated using [system_properties/angle_ceramide_ext.ipynb](system_properties/angle_ceramide_ext.ipynb).

For calculating NSLD plots using SIMtoEXP, the number densities of C, H, O and N atoms along z-axis was calculated using the following command.
```
gmx density -f npt_prod_1-3.trr -s npt_prod_1.tpr -o densities/chon_1-3.xvg -n indices/chon.ndx -center -sl 400 -ng 4 -dens number
``` 
The input files used in SIMtoEXP to generate the NSLD plots for the simulated models are [system_properties/extended_ceramide.sim](system_properties/extended_ceramide.sim) and [system_properties/hairpin_ceramide.sim](system_properties/hairpin_ceramide.sim).

The experimental NSLD plots from Groen et al (Figure 4A in https://doi.org/10.1016/j.bpj.2011.02.001) and Schmitt et al (Figure 3A (dashed line) in https://doi.org/10.1021/acs.langmuir.7b01848) were read using the MATLAB code at https://www.mathworks.com/matlabcentral/fileexchange/7173-grabit (Accessed January 24, 2024).

The NSLD values and the python script used for plotting Figure 9 in the manuscript are [system_properties/NSLD.csv](system_properties/NSLD.csv) and [system_properties/nsld.ipynb](system_properties/nsld.ipynb).

### Hydration simulations
The shell scripts and .mdp files used for the MD simulations performed for analyzing the effect of addition of 10 wt% and 20 wt% water are in [hydration_simulations](hydration_simulations). <br>
Water molecules were inserted into the system using [hydration_simulations/insert_water.sh](hydration_simulations/insert_water.sh).

The simulation scripts were run in the following order.
```
./em.sh
./nvt_eq.sh
./npt_eq.sh
./npt_prod.sh
```
### Umbrella sampling
The shell scripts and .mdp files used for the Steered MD simulations performed for analyzing the permeability of water, benzene and estradiol are in [umbrella_sampling](umbrella_sampling). <br>
Permeants were inserted into the system using [umbrella_sampling/insert.sh](umbrella_sampling/insert.sh). <br>
Short equilibration after insertion of permeants were performed running the scripts in the following order.
```
./em.sh
./nvt_eq.sh
./npt_eq.sh
```
The Steered MD simulatins were perfomed using [umbrella_sampling/pulling.sh](umbrella_sampling/pulling.sh) and [umbrella_sampling/pulling.mdp](umbrella_sampling/pulling.mdp). <br>
The frames were extraccted from Steered MD trajectory at regular intervals using [umbrella_sampling/extract_frames_v2.pl](umbrella_sampling/extract_frames_v2.pl) for performing umbrella sampling. <br>
Umbrella sampling simulatins were perfomed using [umbrella_sampling/us/us.pl](umbrella_sampling/us/us.pl) and [umbrella_sampling/us/us.mdp](umbrella_sampling/us/us.mdp). <br>
The PMF profiles were calculated using [umbrella_sampling/us/wham.sh](umbrella_sampling/us/wham.sh).
The dG associated with the transfer of permeant from bulk water to stratum corneum lipid matrix was calculated using [umbrella_sampling/us/dG_transfer_FEP/run.sh](umbrella_sampling/us/dG_transfer_FEP/run.sh). <br>
The position autocorrelation functions required for deriving the diffusion coefficients were calculated using [umbrella_sampling/us/xacf20.pl](umbrella_sampling/us/xacf20.pl). <br>
### Calculation of permeability coefficients
The folder [permeability_calculation_scripts](permeability_calculation_scripts) contains the MATLAB scripts used for calculation of Permeability Coefficient from PMF and Diffusion Coefficients using Inhomogeneous Solubility Diffusion Model.
### Permeation enhancer simulations
The shell scripts and .mdp files used for the MD simulations performed for analyzing the effect of addition of 5 wt% and 10 wt% of permeation enhancers are in [permeation_enhancer_simulations](permeation_enhancer_simulations). <br>
Permeation enhancer molecules were inserted into the system using [permeation_enhancer_simulations/insert_PE.sh](permeation_enhancer_simulations/insert_PE.sh).

The simulation scripts were run in the following order.
```
./em.sh
./nvt_eq.sh
./npt_eq.sh
./npt_prod.sh
```



