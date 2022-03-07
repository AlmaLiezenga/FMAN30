%initialize values for means, stdvs and size of dataset
s = [0.4, 4]; 
size = [10, 1000]; 
m = [0, 1]; 
parzen = [0.02, ]

%initialize format for datasets 
data = struct; 
data.train1 = zeros(size(1), 2);
data.test1 = zeros(size(2), 2);
data.train2 = zeros(size(1), 2);
data.test2 = zeros(size(2), 2);

%create data for one case: stdv 0.4 and parzen
stdv = s(1); 
R = chol(stdv);
values = repmat(mean,nr,1) + randn(nr,1)*R; 


%iterate over cases and set standard deviation
for i=1:2
    stdv = s(i); 
    if i==1
        ccase = '1'; 
    elseif i==2
        ccase = '2'; 
    end 
    
    %iterate over train/test and set size
    for y=1:2
        nr = size(y); 
        if y==1
                set = 'train'; 
            elseif y==2
                set = 'test'; 
        end 
            
        %iterate over classes and set mean 
        for c=1:2
            mean = m(c); 
            
            %calculate nr samples with mean and stdv 
            R = chol(stdv);
            values = repmat(mean,nr,1) + randn(nr,1)*R; 
            
            %add to the dataset
            dataset = append(set,ccase); 
            data.(dataset) = values;     
        end 
    end
end

%save all data
