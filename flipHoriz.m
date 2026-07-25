function result = flipHoriz(mat)
result = zeros(size(mat,1),2*size(mat,2));
for i = 1:size(mat,1)
    for j = 1:size(mat,2)
        result(i,j) = mat(i,j);
        result(i,2*size(mat,2)+1-j) = mat(i,j);
    end
end
end