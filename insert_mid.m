function [result] = insert_mid(arr,val)
result = [arr(1:floor(end/2)), val, arr(floor(end/2)+1:end)];
end