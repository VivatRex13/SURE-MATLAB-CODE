function [Z_LL,Z_LE,Z_EL,Z_EE] = extractParams(fileName,Z_0,array_size,excitation_index)
S_data = sparameters(fileName);
S = S_data.Parameters;

Z = Z_0*(eye(array_size)+S)/(eye(array_size)-S);
load_index = setdiff(1:array_size,excitation_index);

Z_LL = Z(load_index,load_index);
Z_LE = Z(load_index,excitation_index);
Z_EL = Z(excitation_index,load_index);
Z_EE = Z(excitation_index,excitation_index);
end