load('trainingtestdata.mat')

%set all widths we want to tes
p_values = 0.2:0.005:4; 

%initiate an empty array for the estimations
estimations = NaN(length(p_values),4); 

%try the parzen with all different p values 
for j=1:length(p_values)
    %set the parzen value 
    parzen = p_values(j); 
    
    estimations(j, 1) = parzen;
    
    %class 1 
    estimation = 0; 
    for i=1:length(data.train1)
        %seperate train from test data
        test = data.train1(i);
        train = data.train1; 
        train(i) = [];
        
        %calculate the parzen estimation and add it (log) to the total
        est = my_parzen(test, train, parzen); 
        estimation = estimation + log(est(:,2)); 
    end
    %write the estimation to the array
    estimations(j, 2) = estimation;
    
    %class 2     
    estimation = 0; 
    for i=1:length(data.train2)
        %seperate train from test data
        test = data.train2(i);
        train = data.train2; 
        train(i) = [];
        
        %calculate the parzen estimation and add it (log) to the total
        est = my_parzen(test, train, parzen); 
        estimation = estimation + log(est(:,2));
    end
    %write the estimation to the array
    estimations(j, 3) = estimation; 
    estimations(j, 4) = estimations(j, 3) + estimations(j, 2);
end