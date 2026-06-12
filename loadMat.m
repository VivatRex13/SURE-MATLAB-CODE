function [X_L,Z_LL,Z_LE,Z_EL,Z_EE] = loadMat(fileName, Z_0, Z_targ, f, C_min, C_max, array_size, excitation_index, x0_val)
S_data = sparameters(fileName);
S = S_data.Parameters;
w = 2*pi*f;

Z = Z_0*(eye(array_size)+S)/(eye(array_size)-S);

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

x0 = x0_val*ones(1,20);

X_L = fmincon(fun,x0,[],[],[],[],-1/(w*C_min)*ones(1,20),-1/(w*C_max)*ones(1,20),[],options);
end