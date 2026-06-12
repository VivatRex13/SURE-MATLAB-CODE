Etheta = zeros(21,91);
Ephi = zeros(21,91);

for i = 1:21
    [theta,phi,numFreqs,Etheta_temp,Ephi_temp,freqs] = loadData("meander_10mm_1-9mm_"+i+".ffd","Phi-Theta");
    Etheta(i,:) = Etheta_temp;
    Ephi(i,:) = Ephi_temp;
end

E_targ = zeros(1,91);

for i = 1:21
    E_targ = E_targ + Etheta(i,:);
end

% [x0,Z_LL,Z_LE,Z_EL,Z_EE] = loadMat("UnitCell_Meander_Array_1D_Array_Meander_10mm.s21p",50,50,1e10,0.14e-12,1.1e-12,21,11,-50);

I_E = 1;
V_exc = -Z_LE*I_E;

I_L = (1i*diag(x0)+Z_LL)\V_exc;