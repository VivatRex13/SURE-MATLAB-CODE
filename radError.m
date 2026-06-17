function [result] = radError(X_L,E_targ,Etheta,Z_LL,Z_LE,I_E,weight_mat)
V_exc = -Z_LE*I_E;
I_L = (1i*diag(X_L)+Z_LL)\V_exc;
I_L = I_L.';
I = insert_mid(I_L, I_E);
E_tot = I*Etheta;
E_max = max(E_tot);
E_tot = E_tot/E_max;
err = abs(E_targ) - abs(E_tot);
err = err.*weight_mat;
result = 0.5*(err*err');
end