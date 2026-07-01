function optimC(file_prefix,input_file,X_min,X_max)
load(input_file,"X_mat","theta","Z_LL","Z_LE","Z_EL","Z_EE","I_E","Etheta","E_targ")

fun = @(x) radError(x,E_targ,Etheta,Z_LL,Z_LE,I_E);
options = optimoptions(@fmincon, 'Display','iter', MaxFunctionEvaluations=1000000, UseParallel=true);

X_mat = fmincon(fun,X_mat,[],[],[],[],X_min.*ones(1,20),X_max.*ones(1,20),[],options);
save(file_prefix+".mat","X_mat","theta","Z_LL","Z_LE","Z_EL","Z_EE","I_E","Etheta","E_targ");
end