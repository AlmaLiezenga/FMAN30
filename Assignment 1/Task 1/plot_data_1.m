load('trainingtestdata.mat')

%initialize values for means, stdvs and size of dataset
s = [0.4, 4]; 
size = [10, 1000]; 
m = [0, 1]; 
p = [0.02, 1]; 

%CHANGE for a different stdv and parzen width 
stdv = s(1); 
h = p(1); 

%Class 1
x1 = data.test1;
T1 = data.train1; 
Y1 = data.train1Y; 
mean1 = m(1); 

%Class 2
x2 = data.test2;
T2 = data.train2; 
Y2 = data.train2Y; 
mean2 = m(2); 

%combine all testing data
testing = horzcat(x1, x2);

%initialize format for saving the likelihoods 
likelihood = struct('T1P', NaN(length(testing),2), 'T2P', NaN(length(testing),2), 'totalP', NaN(length(testing),2), 'T1G', NaN(length(testing),2), 'T2G', NaN(length(testing),2), 'totalG', NaN(length(testing),2)); 

%format: T(raining), P(arzen)/G(aussian)
%iterate over all testing data
for i=1:length(testing)
    x = testing(i); 
    
    %Parzen estimations for both classes 
    likelihood.T1P(i, :) = my_parzen(x, T1, h); 
    likelihood.T2P(i, :) = my_parzen(x, T2, h);  
    
    %total Parzen likelihood for a data point according to the law of total
    %probability 
    likelihood.totalP(i, 1) = x; 
    likelihood.totalP(i, 2) = (likelihood.T1P(i, 2) * 0.5)  + (likelihood.T2P(i, 2) * 0.5);
    
    %Gaussian estimations for both classes 
    likelihood.T1G(i, 1) = x;
    likelihood.T1G(i, 2) = normpdf(x, mean1, stdv); 
    likelihood.T2G(i, 1) = x;
    likelihood.T2G(i, 2) = normpdf(x, mean2, stdv); 
    
    %total Gaussian likelihood 
    likelihood.totalG(i, 1) = x; 
    likelihood.totalG(i, 2) = (likelihood.T1G(i, 2) * 0.5) + (likelihood.T2G(i, 2) * 0.5);
end 

%sort rows to enable a nice visualisation
likelihoodT1P = sortrows(likelihood.T1P); 
likelihoodT2P = sortrows(likelihood.T2P); 
likelihoodtotalP = sortrows(likelihood.totalP); 

likelihoodT1G = sortrows(likelihood.T1G); 
likelihoodT2G = sortrows(likelihood.T2G); 
likelihoodtotalG = sortrows(likelihood.totalG); 

%plot 
plot(likelihoodT1P(:,1), likelihoodT1P(:,2))

title('Combined Plots for the Prior')

hold on
plot(likelihoodT2P(:,1), likelihoodT2P(:,2))
plot(likelihoodtotalP(:,1), likelihoodtotalP(:,2))

plot(likelihoodT1G(:,1), likelihoodT1G(:,2))
plot(likelihoodT2G(:,1), likelihoodT2G(:,2))
plot(likelihoodtotalG(:,1), likelihoodtotalG(:,2))

plot(T1, Y1-0.95, '*') 
plot(T2, Y1-0.95, '+') 

legend({'Parzen likelihood for x = class 1','Parzen likelihood for x = class 2', 'Parzen likelihood for x', 'Gaussian (true) likelihood for x = class 1', 'Gaussian (true) likelihood for x = class 2', 'Gaussian (true) likelihood for x','Class 1 Training data', 'Class 2 Training data'},'Location','northeast')

hold off

%save the data
save('likelihoods', 'likelihood')