#gmx_mpi editconf -f esdl_ini.pdb -o esdl.gro -center 0 0 0

gmx_mpi insert-molecules -f npt_eq_8_5_l.gro -ci esdl.gro -nmol 1 -try 10000 -ip ip.dat -dr 2.5 2.5 0 -rot xyz -o sys.gro -scale 0.28
