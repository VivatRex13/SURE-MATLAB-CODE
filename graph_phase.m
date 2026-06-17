S_data = sparameters('straight_ms_unit-cell_zmatrix/Microstrip_Tests_straight_microstrip1_3-5mm.s2p');
S = S_data.Parameters;
Z_0 = 50;
w = 2*pi*10e9;

Z = Z_0*(eye(2)+S)/(eye(2)-S);

Z11 = Z(1,1);
Z12 = Z(1,2);
Z21 = Z(2,1);
Z22 = Z(2,2);

X_vals = linspace(10,100,401);
% C_vals = linspace(0.14e-12,1.09e-12,401);
% X_vals = -1 ./ (w.*C_vals);

Z_in = Z11-(Z12*Z21)./(1i*X_vals+Z22);
S11 = (Z_in-Z_0)./(Z_in+Z_0);

S11_mag = abs(S11);
S11_phase = rad2deg(angle(S11));

plot(X_vals,S11_phase);
ylabel("S11 Phase (deg)")
xlabel("Complex Impedance (\Omega)")
saveas(gcf, 'straight_s11_phase.png');