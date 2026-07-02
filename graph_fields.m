%% CONSTANTS
Z_0 = 50; % Characteristic Impedance
Z_targ = 50; % Target Input Impedance
f = 1e10; % Operating Frequency
w = 2*pi*f;
e_0 = 8.8541878188e-12; % Permittivity of Free Space
u_0 = 4*pi*1e-7; % Permeability of Free Space
k = w*sqrt(u_0*e_0); % Wavenumber
C_min = 0.14e-12; % Minimum Capacitance (F)
X_min = -1 / (w*C_min);
C_max = 1.1e-12; % Maximum Capacitance (F)
X_max = -1 / (w*C_max);
d = 0.00625; % Cell Length (m)

%% EXTRACTING ELEMENT PATTERNS
[Etheta,Ephi,~,~] = extractFields("element_patterns/straight_ms_10mm_3-5mm/straight_3-5mm","Phi-Theta");
[Emtheta,Emphi,theta,phi] = extractFields("element_patterns/2mm_meander_10mm_width/meander_10mm_2mm","Phi-Theta");

%% DEFINING TARGET
E_rl = zeros(1,91);
E_targ = zeros(1,91);

for n = 1:21
    E_targ = E_targ + cos(pi*(n-11)/21)*exp(1i*(n-1)*k*d.*sind(theta));
end
% COSINE ELEMENT cos(pi*(n-11)/21)*
E_targ = E_targ./max(E_targ);

I_E = 1;

% [X_L,Z_LL,Z_LE,Z_EL,Z_EE] = loadMat("straight_ms_zmatrix/UnitCell_Meander_Array_1D_Array_Straight_ZMat_3-5mm_ms.s21p", Z_0, Z_targ, f, 10, 100, 21, 11, 0);

%% OPTIMZING FOR LOAD
x0 = 50.*ones(1,20);

[Xs_mat,Z_LL,Z_LE,Z_EL,Z_EE,I_E] = optimSymOut("straight_ms_zmatrix/UnitCell_Meander_Array_1D_Array_Straight_ZMat_3-5mm_ms.s21p",Etheta,E_targ,x0,10,100,I_E,Z_0,21,11);
[Zm_LL,Zm_LE,Zm_EL,Zm_EE] = extractParams("meander_array_zmatrix/UnitCell_Meander_Array_1D_Array_Meander_10mm_2mm.s21p",Z_0,21,11);
% Map to Capacitance
% Xm_mat = mapLtoC(Xs_mat);
% Xm_mat = optimSymOut("meander_array_zmatrix/UnitCell_Meander_Array_1D_Array_Meander_10mm_2mm.s21p",Emtheta,E_targ,Xm_mat,X_min,X_max,I_E,Z_0,21,11);
% Xm_mat = -1 / (w*1e-12) * ones(1,20);
% Cm_mat = -1 ./ (w*Xm_mat) .* 1e12;
Xm_mat = zeros(1,20);

%% IMPORT HFSS GRAPH
fields_data = readtable("const_cap.csv");
fields_data_arr = table2array(fields_data);
theta_vals = fields_data_arr(:,3);
norm_vals = fields_data_arr(:,4);

%% CHECK INPUT IMPEDANCE
Z_in = Zm_EL/(-1i*diag(Xm_mat)-Zm_LL)*Zm_LE+Zm_EE;

%% GRAPHING OUTPUT
[Es_tot,Ss,Xs_vals] = forwardSolve(Xs_mat,Z_LL,Z_LE,Z_EL,Z_EE,I_E,Etheta);
[Em_tot,Sm,Xm_vals] = forwardSolve(Xm_mat,Zm_LL,Zm_LE,Zm_EL,Zm_EE,I_E,Emtheta);
% [Emo_tot,Smo,Xmo_vals] = forwardSolve("sym_const/meander_2mm_10mm_sym_optim.mat");
plot(theta,20*log10(Em_tot))
hold on
% plot(theta_vals,20*log10(norm_vals))
% plot(theta,20*log10(Em_tot))
% plot(theta,20*log10(Emo_tot))
% plot(theta,20*log10(E_targ))
hold off
title("Radiated E Fields")
xlabel("\theta (deg)")
ylabel("Field Strength (dB)")
legend("Inductive Loads","HFSS Sim","Optimized Capacitive Loads","Target","Location","south")