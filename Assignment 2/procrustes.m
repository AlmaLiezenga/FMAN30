function [Rstar, tstar] = procrustes(sample_he, sample_pe)

%find Rstar and tstar for those points 
bar_he = sum(sample_he, 2)./length(sample_he); %vector of two values
bar_pe = sum(sample_pe, 2)./length(sample_pe); %vector of two values
                
tilde_he = sample_he - bar_he;
tilde_pe = sample_pe - bar_pe; 
                
H = tilde_pe*(tilde_he'); 
[U,~,V] = svd(H); 

%calculate Rstar and tstar
Rstar = U*diag([1, det(U*V')])*V'; 
tstar = (bar_pe - Rstar*bar_he);

end 