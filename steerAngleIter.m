function steerAngleIter(init_ang,final_ang,iter,file_prefix,zmat_file,Etheta,theta,x0,X_min,X_max,I_E,Z_0,arr_size,exc_ind,k,d)
[Z_LL,Z_LE,Z_EL,Z_EE] = extractParams(zmat_file,Z_0,arr_size,exc_ind);

curr_ang = init_ang;

curr_init = x0*ones(1,20);

while curr_ang <= final_ang + 0.00001
    E_targ = zeros(1,size(theta,2));
    for n = 1:21
        E_targ = E_targ + exp(1i*(n-1)*k*d.*(sind(theta)-sind(curr_ang)))/21;
    end

    fun = @(x) radError(x,E_targ,Etheta,Z_LL,Z_LE,I_E);
    options = optimoptions(@fmincon, 'Display','iter', MaxFunctionEvaluations=1000000, UseParallel=true);
    X_mat = fmincon(fun,curr_init,[],[],[],[],X_min,X_max,[],options);
    % curr_init = X_mat;
    save("mat_files/"+file_prefix+"_"+round(curr_ang)+"deg.mat","X_mat","Z_LL","Z_LE","Z_EL","Z_EE","I_E","Etheta","E_targ");
    curr_ang = curr_ang + iter;
end