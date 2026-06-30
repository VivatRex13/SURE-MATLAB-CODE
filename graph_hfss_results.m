meander_fields_data = readtable("sym_const/meander_2mm_sym.csv");
meander_fields_data_arr = table2array(meander_fields_data);
meander_theta_vals = meander_fields_data_arr(:,3);
meander_norm_vals = meander_fields_data_arr(:,4);

straight_fields_data = readtable("straight_ms_fields_data/straight_ms_3-5mm_sym.csv");
straight_fields_data_arr = table2array(straight_fields_data);
straight_theta_vals = straight_fields_data_arr(:,3);
straight_norm_vals = straight_fields_data_arr(:,4);

plot(meander_theta_vals,20*log10(meander_norm_vals));
hold on
plot(straight_theta_vals,20*log10(straight_norm_vals));
hold off
legend("Meander","Straight");
xlabel("\theta (deg)");
ylabel("Normalized Field Magnitude (dB)");
saveas(gcf, 'figures/meander_vs_straight_sym_hfss.png');