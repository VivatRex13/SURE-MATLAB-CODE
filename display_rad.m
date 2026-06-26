fields_data = readtable("fields_data/meander_2mm_cos.csv");
% ang = 10;
load("mat_files/meander_2mm_10mm_cos.mat","Z_LE","I_E","Z_LL")
load("mat_files/straight_3-5mm_10mm_cos.mat","Etheta","E_targ")
% load("mat_files/straight_3-5mm_10mm_"+ang+"deg.mat","Etheta","E_targ")
load("mat_files/meander_2mm_10mm_cos_mapped.mat","X_vals")
% Xm_vals = X_vals;
% load("mat_files/meander_2mm_10mm_sym_optim.mat","X_vals")
% X_vals = X_vals(angle/5+1);
fields_data_arr = table2array(fields_data);
theta_vals = fields_data_arr(:,3);
norm_vals = fields_data_arr(:,4);
w = 2*pi*1e10;

% V_exc = -Z_LE*I_E;
% I_L = (1i*diag(Xm_vals)+Z_LL)\V_exc;
% I_L = I_L.';
% I = insert_mid(I_L, I_E);
% E_tot = I*Etheta;
% E_max = max(E_tot);
% Em_tot = E_tot / E_max;

V_exc = -Z_LE*I_E;
I_L = (1i*diag(X_vals)+Z_LL)\V_exc;
I_L = I_L.';
I = insert_mid(I_L, I_E);
E_tot = I*Etheta;
E_max = max(E_tot);
E_tot = E_tot / E_max;

plot(theta,20*log10(abs(E_tot)))
hold on
% plot(theta,20*log10(abs(Em_tot)),"--","LineWidth",2)
plot(theta,20*log10(abs(E_targ)))
plot(theta_vals,20*log10(abs(norm_vals)))
hold off
% legend("Total E Field (MATLAB)", "Target E Field")
legend("Total E Field (MATLAB)", "Target E Field", "Total E Field (HFSS)", "Location","south")
title("Symmetric Capacitive Loads E Field Cosine")
xlabel("\theta (deg)")
ylabel("Normalized Magnitude")

saveas(gcf, 'figures/2mm_meander_cos.png');

C_vals = -1 ./ (w*X_vals) * 1e12;

plot(1:20,C_vals);
title("Symmetric Capacitive Loads E Field Cosine")
xlim([1,20])
xlabel("Load-Terminated Antenna")
ylabel("Capacitance (pF)")
saveas(gcf, 'figures/2mm_meander_cos_loads.png');

% L_mat = X_mat ./ (w) .* 1e9;

% Z_excited = Z_EL/(-1i*diag(X_mat)-Z_LL)*Z_LE+Z_EE