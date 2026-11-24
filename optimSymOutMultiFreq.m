function [X_mat,Z_LL,Z_LE,Z_EL,Z_EE,I_E] = optimSymOutMultiFreq(zmat_file,Etheta,E_targ,x0,X_min,X_max,I_E,Z_0,arr_size,exc_ind,f_min,f_max,count)
[Z_LL,Z_LE,Z_EL,Z_EE] = extractParams(zmat_file,Z_0,arr_size,exc_ind);

curr_init = x0(1,1:10);

freqs = zeros(count);
step = (f_max-f_min)/(count-1);

for i = 1:count
    freqs(i) = f_min+(i-1)*step;
end

fun = @(x) radErrorSym(x,E_targ,Etheta,Z_LL,Z_LE,I_E);
options = optimoptions(@fmincon, 'Display','iter', MaxFunctionEvaluations=1000000, UseParallel=true);

X_mat_half = fmincon(fun,curr_init,[],[],[],[],X_min.*ones(1,10),X_max.*ones(1,10),[],options);
X_mat = zeros(1,arr_size-size(exc_ind,2));

for i = 1:10
    X_mat(1,i) = X_mat_half(1,i);
    X_mat(1,arr_size-i) = X_mat_half(1,i);
end