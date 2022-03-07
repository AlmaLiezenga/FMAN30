%initialize values for means, stdvs and size of dataset
s = [0.4, 4]; 
size = [10, 1000]; 
m = [0, 1]; 
p = [0.02, 1]; 

%initialize format for datasets 
data = struct; 

%create data for one case, CHANGE for a different stdv 
stdv = s(1); 

%class 1 
data.train1 = normrnd(m(1),stdv,[1,size(1)]); 
data.train1Y = ones(size(1),1);
data.test1 = normrnd(m(1),stdv,[1,size(2)]); 
data.test1Y = ones(size(2),1);  

%class 2 
data.train2 = normrnd(m(2),stdv,[1,size(1)]); 
data.train2Y = repmat(2,size(1),1); 
data.test2 = normrnd(m(2),stdv,[1,size(2)]); 
data.test2Y = repmat(2,size(2),1); 

%save the data
save('trainingtestdata', 'data')