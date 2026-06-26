load("mat_files/meander_2mm_10mm_mapped.mat","X_vals");
load("mat_files/straight_3-5mm_10mm_sym.mat","Etheta","E_targ")

x0 = X_vals(:,1:end/2);
Z_0 = 50;
I_E = 1;
C_min = 0.14e-12; % Minimum Capacitance (F)
X_min = -1 / (w*C_min);
C_max = 1.1e-12; % Maximum Capacitance (F)
X_max = -1 / (w*C_max);

optimSym("meander_2mm_10mm_sym_optim","meander_array_zmatrix/UnitCell_Meander_Array_1D_Array_Meander_10mm_2mm.s21p",Etheta,E_targ,x0,X_min,X_max,I_E,Z_0,21,11);