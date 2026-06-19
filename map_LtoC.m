S_data = sparameters('straight_ms_unit-cell_zmatrix/Microstrip_Tests_straight_microstrip_3-5mm.s2p');
S_data_m = sparameters('meander_unit-cell_zmatrix/Microstrip_Tests_one_squiggle_2mm.s2p');
load("mat_files/straight_3-5mm_10mm_0deg.mat","X_mat")
S = S_data.Parameters;
Sm = S_data_m.Parameters;
Z_0 = 50;
w = 2*pi*10e9;

Z = Z_0*(eye(2)+S)/(eye(2)-S);
Zm = Z_0*(eye(2)+Sm)/(eye(2)-Sm);

Z11 = Z(1,1);
Z12 = Z(1,2);
Z21 = Z(2,1);
Z22 = Z(2,2);

Z11m = Zm(1,1);
Z12m = Zm(1,2);
Z21m = Zm(2,1);
Z22m = Zm(2,2);

Z_in = Z11-(Z12*Z21)./(1i*X_mat+Z22);

Xm_vals = -1i*(Z11m-(Z12m*Z21m)./Z_in-Z22m);

C_vals = 1 ./ (w*Xm_vals)