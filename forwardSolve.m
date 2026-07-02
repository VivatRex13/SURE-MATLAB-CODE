function [E_tot,S,X_L] = forwardSolve(X_mat,Z_LL,Z_LE,Z_EL,Z_EE,I_E,Etheta)
X_L = X_mat;
V_exc = -Z_LE*I_E;
I_L = (1i*diag(X_L)+Z_LL)\V_exc;
I_L = I_L.';
I = insert_mid(I_L, I_E);
E_tot = I*Etheta;
E_max = max(abs(E_tot));
E_tot = E_tot / E_max;

Z_in = Z_EL/(-1i*diag(X_L)-Z_LL)*Z_LE+Z_EE;
S = z2s(Z_in,50);
end