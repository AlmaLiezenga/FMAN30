function f = my_parzen(x, T, h) 

%create an empty array to store the result in
f = zeros(length(x), 2); 

    %iterate over all the points in the testing data 
    for i = 1:length(x)
        
        %store the value of the current point in the output
        f(i, 1) = x(i); 
        point = x(i); 
        total = 0; 

        %iterate over all training points 
        for j = 1: length(T)
            
            %calculate the distance to the training point
            trainpoint = T(j);  
            distance = point - trainpoint; 

            %calculate the kernel
            Gkernel = exp(-(((distance/h).^2)/2));

            %add the weight of the current point
            total = total + ((1/h) * Gkernel);    
        end 
        
        %finalize the equation
        n = length(T);  
        f(i, 2) = (1/n) * total; 
    end 
end 