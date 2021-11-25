function [inliersList, inliers] = get_inliers(Rstar, tstar, field, data, threshold, n, sample)

%set the basic values 
inliers = n; 
inliersList = []; 

    for s=1:length(sample) 
        inliersList(:,s) = sample(:,s);
    end 

    for u=1:length(data.(field).matches)
        %get the sample for this match
        sample = data.(field).matches(:,u);
        [sample_he, sample_pe] = get_samples(sample, field, data); 

        %estimate y according to the current model
        estimate_pe = (Rstar*sample_he) + tstar; 

        %check if they align?
        if abs(sample_pe-estimate_pe) < threshold
            inliers = inliers + 1;
            inliersList(:,inliers) = sample; 
        end 
    end 
    
end  