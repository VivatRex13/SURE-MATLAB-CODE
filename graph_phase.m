S_data = sparameters('straight_ms_unit-cell_zmatrix/Microstrip_Tests_straight_microstrip_3-5mm.s2p');
S_data_m = sparameters('meander_unit-cell_zmatrix/Microstrip_Tests_one_squiggle_2mm.s2p');
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

X_vals = linspace(10,100,401);
C_vals = linspace(0.14e-12,1.09e-12,401);
Xm_vals = -1 ./ (w.*C_vals);

Z_in = Z11-(Z12*Z21)./(1i*X_vals+Z22);
S11 = (Z_in-Z_0)./(Z_in+Z_0);

Zm_in = Z11m-(Z12m*Z21m)./(1i*Xm_vals+Z22m);
S11m = (Zm_in-Z_0)./(Zm_in+Z_0);

S11_mag = abs(S11);
S11_phase = rad2deg(angle(S11));

S11m_mag = abs(S11m);
S11m_phase = rad2deg(angle(S11m));

t = tiledlayout(1,1);
ax1 = axes(t);
plot(ax1,X_vals,S11_phase,"-k")
ax2 = axes(t);
plot(ax2,Xm_vals,S11m_phase,'-r')
ax2.XAxisLocation = 'top';
ax2.Color = 'none';
ax1.Box = 'off';
ax2.Box = 'off';
title("S11 vs Inductance")
ylabel("S11 Phase (deg)")
xlabel("Reactance (\Omega)")
saveas(gcf, 'figures/straight_meander_s11_phase.png');