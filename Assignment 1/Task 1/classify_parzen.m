load('trainingtestdata.mat')
load('posteriors.mat')

%create an empty struct to store the outcome (could also have beeen an array)
classification = struct('parzen', NaN(length(posterior.C1P),3));

%iterate all data
for i=1:length(posterior.C1P)
    classification.parzen(i, 1) = posterior.C1P(i, 1);
    
    %check which posterior is higher 
    if posterior.C1P(i, 2) > posterior.C2P(i, 2)
        classification.parzen(i, 2) = 1; 
    else
        classification.parzen(i, 2) = 2; 
    end 
    
    %check the true value of the data point
    for j=1:length(data.test1)
        if classification.parzen(i, 1) == data.test1(j)
            classification.parzen(i, 3) = 1;
        elseif classification.parzen(i, 1) == data.test2(j)
            classification.parzen(i, 3) = 2;
        end 
    end 
end 

%iterate over all data points to see if they are correctly classified  
errors = 0; 
for x=1:length(classification.parzen)
    if classification.parzen(x, 2) ~= classification.parzen(x, 3)
        errors = errors + 1; 
    end     
end 

%calculate the error rate
errorrate = errors/length(classification.parzen); 

%save the data
save('parzen_classification', 'classification')