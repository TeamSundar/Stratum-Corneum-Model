#ls -rt */*pullf* > pullf-files.dat
#ls -rt */*tpr > tpr-files.dat


gmx wham -if pullf-files.dat -it tpr-files.dat -o profile_20-45.xvg -hist histo_20-45.xvg -bins 54 -b 20000 -e 45000 -temp 303.15 -zprof0 -1.6 -min -1.65 -max 1.05 -nBootstrap 100 -bs-method traj -ac -oiact iact_20-45_bins54.xvg -bsres bsres_20-45_bins54.xvg -bsprof bsprof_20-45_bins54.xvg 

