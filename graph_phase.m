S_data = sparameters('straight_ms_unit-cell_zmatrix/Microstrip_Tests_straight_microstrip_3-5mm.s2p');
S_data_m = sparameters('meander_unit-cell_zmatrix/Microstrip_Tests_one_squiggle_thick_1mm.s2p');

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

% --- Plotting Section ---
t = tiledlayout(1,1);

% Bottom Axis & Plot (Straight MS)
ax1 = axes(t);
h1 = plot(ax1, X_vals, S11_phase, "-k", "LineWidth", 2);
xlabel(ax1, "Reactance (\Omega)", "FontSize", 18);
ylabel(ax1, "S11 Phase (deg)", "FontSize", 18);
ax1.FontSize = 18;

% Top Axis & Plot (Meander MS)
ax2 = axes(t);
h2 = plot(ax2, Xm_vals, S11m_phase, '-r', "LineWidth", 2);
ax2.XAxisLocation = 'top';
ax2.Color = 'none';

% Make the top x-axis line and ticks red
ax2.XAxis.Color = 'r';
ax2.FontSize = 18;

% --- Y-Axis Synchronization ---
% Find the combined min and max across both datasets
y_min = min([S11_phase, S11m_phase]);
y_max = max([S11_phase, S11m_phase]);

% Set the exact same Y-limits for both axes
ylim(ax1, [y_min, y_max]);
ylim(ax2, [y_min, y_max]);

% Alternatively, if you want them linked dynamically in interactive figures:
% linkaxes([ax1, ax2], 'y');

% Clean up overlapping boxes
ax1.Box = 'off';
ax2.Box = 'off';

title("S11 vs Inductance", "FontSize", 18);

% Create legend using line handles from both axes
lgd = legend([h1, h2], {"Straight MS", "Meander MS"}, 'Location', 'best');
lgd.FontSize = 16;

saveas(gcf, 'figures/straight_2mm_meander_s11_phase.png');