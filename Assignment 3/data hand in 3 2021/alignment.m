function aligned_shape = alignment(Rstar, tstar, sstar, shape)

aligned_shape = shape; 

for i=1:size(shape, 1)
    point = transpose(shape(i, :)); 
    estimate_point = (sstar * Rstar * point) + tstar; 
    aligned_shape(i, :) = estimate_point; 
end  

end 