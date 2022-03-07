load('trainingtestdata.mat')

threshold = 0.5; 

testing = horzcat(data.test1, data.test2);

classification = struct('gaussian', NaN(length(testing),3));


for i=1:length(testing)
    
    classification.gaussian(i, 1) = testing(i);  
    
    if classification.gaussian(i, 1) < 0.5
        classification.gaussian(i, 2) = 1; 
    else 
        classification.gaussian(i, 2) = 2; 
    end
    
    %find the true class
    for j=1:length(data.test1)
        if classification.gaussian(i, 1) == data.test1(j)
            classification.gaussian(i, 3) = 1;
        elseif classification.gaussian(i, 1) == data.test2(j)
            classification.gaussian(i, 3) = 2;
        end 
    end 
end 

errors = 0; 
%iterate over all data points to see if they are correctly classified  
for x=1:length(classification.gaussian)
    if classification.gaussian(x, 2) ~= classification.gaussian(x, 3)
        errors = errors + 1; 
    end     
end 

errorrate = errors/length(classification.gaussian); 


save('gaussian_classification', 'classification')
