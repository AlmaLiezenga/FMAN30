load('trainingtestdata.mat')
load('likelihoods.mat')

%initialize format for saving the posteriors 
posterior = struct('C1P', NaN(length(likelihood.T1P),2), 'C2P', NaN(length(likelihood.T2P),2), 'C1G', NaN(length(likelihood.T1G),2), 'C2G', NaN(length(likelihood.T2G),2)); 
prior = 0.5;

%iterate over all testing data
for i=1:length(likelihood.T1P)
    %calculate and assign the posterior with Parzen likelihoods
    posterior.C1P(i, 1) = likelihood.T1P(i, 1); 
    posterior.C1P(i, 2) = (prior * likelihood.T1P(i, 2))/likelihood.totalP(i, 2); 
    posterior.C2P(i, 1) = likelihood.T2P(i, 1); 
    posterior.C2P(i, 2) = (prior * likelihood.T2P(i, 2))/likelihood.totalP(i, 2); 
    
    %calculate and assign the posterior with Gaussian likelihoods
    posterior.C1G(i, 1) = likelihood.T1G(i, 1);
    posterior.C1G(i, 2) = (prior * likelihood.T1G(i, 2))/likelihood.totalG(i,2); 
    posterior.C2G(i, 1) = likelihood.T2G(i, 1);
    posterior.C2G(i, 2) = (prior * likelihood.T2G(i, 2))/likelihood.totalG(i,2);
end

%sort rows to enable a nice visualisation
posteriorC1P = sortrows(posterior.C1P); 
posteriorC2P = sortrows(posterior.C2P); 

posteriorC1G = sortrows(posterior.C1G); 
posteriorC2G = sortrows(posterior.C2G); 

%plot everything 
plot(posteriorC1P(:,1), posteriorC1P(:,2))
title('Combined Plots for the Posterior')

hold on

plot(posteriorC2P(:,1), posteriorC2P(:,2))
plot(posteriorC1G(:,1), posteriorC1G(:,2))
plot(posteriorC2G(:,1), posteriorC2G(:,2))

legend({'Parzen posterior estimation for x = class 1','Parzen posterior estimation for x = class 2', 'Gaussian (true) posterior for x = class 1','Gaussian (true) posterior for x = class 2'},'Location','northeast')

hold off

%save the data 
save('posteriors', 'posterior')