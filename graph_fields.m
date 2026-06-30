[Es_tot,Ss,Xs_vals] = forwardSolve("sym_const/straight_3-5mm_10mm_sym.mat");
[Em_tot,Sm,Xm_vals] = forwardSolve("sym_const/meander_2mm_10mm_sym_mapped.mat");
theta=linspace(-90,90,91);
plot(theta,20*log10(Es_tot))
hold on
plot(theta,20*log10(Em_tot))
plot(theta,20*log10(E_targ))
hold off