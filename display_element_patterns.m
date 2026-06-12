Etheta = zeros(21,91);
Ephi = zeros(21,91);

Z_0 = 50;
Z_targ = 50;
f = 1e10;
w = 2*pi*f;
e_0 = 8.854e-12;
u_0 = 1.2566e-7;
k = w*sqrt(u_0*e_0);
C_min = 0.14e-12;
C_max = 1.1e-12;

d = 0.00625;

for i = 1:21
    [theta,phi,numFreqs,Etheta_temp,Ephi_temp,freqs] = loadData("meander_10mm_1-9mm_"+i+".ffd","Phi-Theta");
    Etheta(i,:) = Etheta_temp;
    Ephi(i,:) = Ephi_temp;
end

E_targ = zeros(1,91);

% for n = -10:10
%     E_targ = E_targ + exp(1i*n*k*d.*cos(theta));
% end

E_targ = 1/21.*(sin(21/2*k*d.*cos(theta))./sin(1/2*k*d.*cos(theta)));

plot(theta,abs(E_targ))

[x0,Z_LL,Z_LE,Z_EL,Z_EE] = loadMat("UnitCell_Meander_Array_1D_Array_Meander_10mm.s21p",Z_0,Z_targ,f,C_min,C_max,21,11,-50);

I_E = 10;

fun = @(x) radError(x,E_targ,Etheta,Z_LL,Z_LE,I_E);
options = optimoptions(@fmincon, 'Display','iter', MaxFunctionEvaluations=1000000, UseParallel=true);

% X_mat = fmincon(fun,x0,[],[],[],[],-1/(w*C_min)*ones(1,20),-1/(w*C_max)*ones(1,20),[],options);

% C_mat = -1 ./ (w .* X_mat);