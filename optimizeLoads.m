function [X_mat] = optimizeLoads(E_targ,Etheta,Z_LL,Z_LE,I_E,weight_mat,X_min,X_max)
fun = @(x) radError(x,E_targ,Etheta,Z_LL,Z_LE,I_E,weight_mat);
options = optimoptions(@fmincon, 'Display','iter', MaxFunctionEvaluations=1000000, UseParallel=true);
X_mat = fmincon(fun,x0,[],[],[],[],X_min*ones(1,20),X_max*ones(1,20),[],options);
end