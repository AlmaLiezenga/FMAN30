load('HEpeData.mat');

%RANSAC variables, should alter these a bit to get a higher k  
n = 2; 
alfa = 0.95;
p = 0.1;
k = log(1-alfa)/log(1-p^n); 
threshold = 20; 

%initialize empty struct for best inliers, Rstars and tstars
best = struct(); 

%RANSAC 
for i=1:9
    for j=1:8
        
        field = strcat('image',num2str(i-1),num2str(j-1));  
        
        if isfield(data,field)
            %set the current 'highest' number of inliers for this image to 0
            bestinliers =  n;

            %iterate over random samples
            for it=1:k
                % get a random sample
                index = randsample(1:length(data.(field).matches), n);
                sample = data.(field).matches(:,index);
                [sample_he, sample_pe] = get_samples(sample, field, data); 
                
                %run procrustes over these points 
                [Rstar, tstar] = procrustes(sample_he, sample_pe);
                
                %calculate how many and which inliers there are for this
                %Rstar and tstar
                [inliersList, inliers] = get_inliers(Rstar, tstar, field, data, threshold, n, sample); 

                %check if this is better than the best inliers so far
                if inliers > bestinliers
                    bestinliers = inliers; 
                    bestinliersList = inliersList; 
                    bestRstar = Rstar; 
                    besttstar = tstar;
                end 
            end             
                
            %create a new Rstar and tstar with all the inliers of the best
            %sample 
            [best_sample_he, best_sample_pe] = get_samples(bestinliersList, field, data); 
            [bestRstar, besttstar] = procrustes(best_sample_he, best_sample_pe); 
            
            %calculate the new amount of inliers 
            [bestinliersList, bestinliers] = get_inliers(bestRstar, besttstar, field, data, threshold, n, bestinliersList);
            
            %save all the values 
            best.(field).Rstar = bestRstar; 
            best.(field).tstar = besttstar;
            best.(field).inliers = bestinliers;
            best.(field).inliersList = bestinliersList;
        end 
    end 
end

for i=1:8
    for j=1:7
        field = strcat('image',num2str(i),num2str(j));  
        if isfield(data,field)
            display(best.(field).inliers); 
        end 
    end  
end
save('RANSAC_resultsn2t20', 'best'); 