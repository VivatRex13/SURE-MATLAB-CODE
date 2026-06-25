function [result] = radErrorSym(X_L,E_targ,Etheta,Z_LL,Z_LE,I_E)
X_L_tot = zeros(1,20);
for i = 1:10
    X_L_tot(1,i) = X_L(1,i);
    X_L_tot(1,21-i) = X_L(1,i);
end
V_exc = -Z_LE*I_E;
I_L = (1i*diag(X_L_tot)+Z_LL)\V_exc;
I_L = I_L.';
I = insert_mid(I_L, I_E);
E_tot = I*Etheta;
E_max = max(E_tot);
E_tot = E_tot/E_max;
err = abs(E_targ) - abs(E_tot);
result = 0.5*(err*err');
end