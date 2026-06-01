S_data = sparameters('1D_Antenna_Array_Parallel_Microstrip_ZMatrix_10mm.s21p');
S = S_data.Parameters;
Z_0 = 50;
Z_targ = 100;

f = 1e10;
w = 2*pi*f;

C_min = 1e-12;
C_max = 20e-12;

Z = Z_0*(eye(21)+S)/(eye(21)-S);
S11_dB = -0.68496748;
S11_phase = -2.7159;
S11 = 10^(S11_dB/20)*exp(1i*S11_phase);

excitation_index = 11;

Z_LL = Z;
Z_LL(excitation_index,:) = [];
Z_LL(:,excitation_index) = [];

Z_LE = Z(:,excitation_index);
Z_LE(excitation_index) = [];

Z_EL = Z(excitation_index,:);
Z_EL(excitation_index) = [];

Z_EE = Z(excitation_index,excitation_index);

fun = @(x) abs(Z_EL/(-1i*diag(x)-Z_LL)*Z_LE+Z_EE-Z_targ)^2;
options = optimoptions(@fmincon, MaxFunctionEvaluations=1000000, UseParallel=true);

x0 = -80*ones(1,20);

% Z_mat = fmincon(fun,x0,[],[],[],[],zeros(20),200*ones(20),[],options);
Z_mat = fmincon(fun,x0,[],[],[],[],-1/(w*C_min)*ones(1,20),-1/(w*C_max)*ones(1,20),[],options)

% Z11 = Z_0*(1+S11)/(1-S11);
Z_excited = Z_EL/(-1i*diag(Z_mat)-Z_LL)*Z_LE+Z_EE

% L_vec = Z_mat ./ (2*pi*10^10)*10^9
C_vec = -1 ./ (2*pi*10^10*Z_mat)*10^12