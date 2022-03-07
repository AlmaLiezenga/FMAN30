function [sample_he, sample_pe] = get_samples(sample, field, data)

[sample_he, sample_pe] = deal(0);

%get the x and y for both indices 
for s=1:size(sample, 2)
    sample_he(1, s) = data.(field).hek(1, sample(1, s));
    sample_he(2, s) = data.(field).hek(2, sample(1, s));
    sample_pe(1, s) = data.(field).pek(1, sample(2, s));
    sample_pe(2, s) = data.(field).pek(2, sample(2, s));
end

end