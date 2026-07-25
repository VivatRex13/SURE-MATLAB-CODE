% CONSTANTS
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
I_E = 1;

% Extract Element Patterns
[Etheta,Ephi,~,~] = extractFields("element_patterns/straight_ms_10mm_3-5mm/straight_3-5mm","Phi-Theta");
[Emtheta,Emphi,theta,phi] = extractFields("element_patterns/2mm_meander_10mm_width/meander_10mm_2mm","Phi-Theta");

% DEFINING TARGET
E_rl = zeros(1,91);
E_targ = zeros(1,91);

for n = 1:21
    E_targ = E_targ + exp(1i*(n-1)*k*d.*sind(theta));
end
% COSINE ELEMENT cos(pi*(n-11)/21)*
E_targ = E_targ./max(E_targ);

% Extract Z params
[Zm_LL,Zm_LE,Zm_EL,Zm_EE] = extractParams("meander_array_zmatrix/UnitCell_Meander_Array_1D_Array_Meander_10mm_2mm.s21p",Z_0,21,11);

% Define Z matrices
x0 = 50.*ones(1,20);

[Xs_mat,Z_LL,Z_LE,Z_EL,Z_EE,I_E] = optimSymOut("straight_ms_zmatrix/UnitCell_Meander_Array_1D_Array_Straight_ZMat_3-5mm_ms.s21p",Etheta,E_targ,x0,10,100,I_E,Z_0,21,11);
Xval = -60;
Cvals = -1 / (w*Xval) * 1e12 * ones(10,10);
X_mat = mapLtoC(Xs_mat);
X_mat = optimSymOut("meander_array_zmatrix/meander_zmat.s21p",Emtheta,E_targ,X_mat,X_min,X_max,I_E,Z_0,21,11);
C_mat = -1 ./ (w*X_mat) .* 1e12;
for i = 1:10
    for j = 1:i
        Cvals(i,j) = C_mat(j);
    end
end
Cmat = flipHoriz(Cvals);
Zmat = -1 ./ (w.*Cmat) * 1e12;

% Find E fields
Etot = zeros(10,91);
for i = 1:10
    [Etot(i,:),~,~] = forwardSolve(Zmat(i,:),Zm_LL,Zm_LE,Zm_EL,Zm_EE,I_E,Emtheta);
end

% Import HFSS Graph
fields_data = readtable("test/optimized_test_fields.csv");
fields_data_arr = table2array(fields_data);
theta_vals = fields_data_arr(:,1);
norm_vals = zeros(91,10);

for i = 1:10
    norm_vals(:,i) = fields_data_arr(:,1+i);
end

for i = 1:10
    plot(theta,20.*log10(abs(Etot(i,:))))
    hold on
    plot(theta_vals,20.*log10(norm_vals(:,i)))
    hold off
    title("Radiation Pattern State "+i)
    xlabel("\theta (deg)")
    ylabel("Field Strength (dB)")
    legend("MATLAB","HFSS Sim")
    saveas(gcf,"figures/test_fields/optim_const_state"+i+".png")
end