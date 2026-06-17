fields_data = readtable("fields_data/straight_ms_3-5mm_fields.csv");
load("mat_files/straight_3-5mm_10mm.mat","X_mat","Z_LE","I_E","Z_LL","E_targ","Etheta")
fields_data_arr = table2array(fields_data);
theta_vals = fields_data_arr(:,3);
norm_vals = fields_data_arr(:,4);

V_exc = -Z_LE*I_E;
I_L = (1i*diag(X_mat)+Z_LL)\V_exc;
I_L = I_L.';
I = insert_mid(I_L, I_E);
E_tot = I*Etheta;
E_max = max(E_tot);
E_tot = E_tot / E_max;

plot(theta,20*log10(abs(E_tot)))
hold on
plot(theta,20*log10(abs(E_targ)))
plot(theta_vals,20*log10(abs(norm_vals)))
hold off
legend("Total E Field (MATLAB)", "Target E Field", "Total E Field (HFSS)")
xlabel("\theta (deg)")
ylabel("Normalized Magnitude")