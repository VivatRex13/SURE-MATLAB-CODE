V_exc = -Z_LE*I_E;
I_L = (1i*diag(X_mat)+Z_LL)\V_exc;
I_L = I_L.';
I = insert_mid(I_L, I_E);
E_tot = I*Etheta;
E_max = max(E_tot);
E_tot = E_tot / E_max;

plot(theta,abs(E_tot))
hold on
plot(theta,abs(E_targ))
hold off