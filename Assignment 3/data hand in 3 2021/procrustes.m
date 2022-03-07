function [Rstar, tstar, sstar] = procrustes(sample_ref, sample_temp)

sample_ref = sample_ref';
sample_temp = sample_temp';

%find Rstar and tstar for those points 
bar_ref = sum(sample_ref, 2)./length(sample_ref); %vector of two values
bar_temp = sum(sample_temp, 2)./length(sample_temp); %vector of two values
                
tilde_ref = sample_ref - bar_ref;
tilde_temp = sample_temp - bar_temp; 
  
H = zeros(2,2); 
for j=1:size(tilde_ref, 1)
    H = H + (tilde_temp(:,j) * tilde_ref(:,j)'); 
end 
[U,~,V] = svd(H); 

%calculate Rstar and tstar
Rstar = U*diag([1, det(U*V')])*V'; 

num = 0; 
denom = 0; 
for z=1:size(tilde_ref)
    num = num + (transpose(tilde_temp(:,z)) * Rstar * tilde_ref(:,z)); 
    denom = denom + transpose(tilde_ref(:,z)) * tilde_ref(:,z); 
end 

sstar = num/denom; 
tstar = (bar_temp - sstar*Rstar*bar_ref);