Z_0_line = 52.34;
Z_0_port = 50;
elec_len = deg2rad(62.11);

L_vals = linspace(10,100,401);

Z_in = Z_0_line.*(1i*L_vals+1i*Z_0_line*tan(elec_len))./(Z_0_line-L_vals.*tan(elec_len));
S11 = (Z_in-Z_0_port)./(Z_in+Z_0_port);
S11_mag = abs(S11);
S11_phase = rad2deg(angle(S11));

plot(L_vals,S11_phase);