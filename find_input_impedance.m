S_data = sparameters('UnitCell_Meander_Array_1D_Array_Meander_6-25mm.s21p');
S = S_data.Parameters;
Z_0 = 50;
Z_targ =50;

f = 1e10;
w = 2*pi*f;

C_min = 0.14e-12;
C_max = 1.1e-12;

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
options = optimoptions(@fmincon, 'Display','iter', MaxFunctionEvaluations=1000000, UseParallel=true);

x0 = -50*ones(1,20);
% x0=[ -52.8930  -31.2704  -22.2615  -31.1704  -69.3736  -88.3981  -15.6393...
%     -28.7084  -33.2554  -55.9681  -47.2221  -36.9626  -21.9016...
%   -94.5976  -23.2800  -74.9148  -31.7391  -69.9663  -34.9393  -82.4837];
% Z_mat = fmincon(fun,x0,[],[],[],[],-300*ones(20),0*ones(20),[],options);
Z_mat = fmincon(fun,x0,[],[],[],[],-1/(w*C_min)*ones(1,20),-1/(w*C_max)*ones(1,20),[],options);
% Z_mat = fmincon(fun,x0,[],[],[],[],-300*ones(1,20),0*ones(1,20),[],options)

% Z_mat = -1 ./ (2*pi*10^10*0.14e-12)*ones(1,20);

% Z11 = Z_0*(1+S11)/(1-S11);
Z_excited = Z_EL/(-1i*diag(Z_mat)-Z_LL)*Z_LE+Z_EE

% L_vec = Z_mat ./ (2*pi*10^10)*10^9
C_vec = -1 ./ (2*pi*10^10*Z_mat)*10^12;
% C_vec = double(vpa(C_vec))