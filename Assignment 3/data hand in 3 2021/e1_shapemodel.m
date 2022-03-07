load('models.mat');
load('dmsa_images.mat')

%get the sample for the first segmentation
reference_shape = models(:, 1);
sample_ref = [real(reference_shape), imag(reference_shape)];

%create a struct to save all aligned shapes
aligned_shapes = struct();
aligned_shapes.shape1 = sample_ref;

%create a struct all the reference shapes/the model for each iteration
reference_shapes = struct();
reference_shapes.shape1 = sample_ref;

%set the number of iterations
iterations = 5;

for it=1:iterations
    %the reference shape should be the first shape for the first run and
    %after that should be the mean shape
    field = strcat('shape',num2str(it));
    sample_ref = reference_shapes.(field);
    
    %Align each shape to the first or mean
    for i=2:size(models, 2)
        %calculate R, t and s
        template_shape = models(:, i);
        sample_temp = [real(template_shape), imag(template_shape)];
        [Rstar, tstar, sstar] = procrustes(sample_temp, sample_ref );
        %align and store the shape
        field = strcat('shape',num2str(i));
        aligned_shapes.(field) = alignment(Rstar, tstar, sstar, sample_temp);
    end
    
    %Calculate the mean of the aligned shapes
    mean_shape = zeros(14, 2);
    for j=1:size(mean_shape, 1)
        total = zeros(1, 2);
        for z=1:40
            field = strcat('shape',num2str(z));
            values = aligned_shapes.(field)(j,:);
            total = total + values;
        end
        mean_shape(j,:) = (1/40) * total;
    end
    
    %Align the mean shape to the first (to guarantee convergence)
    [Rstar, tstar, sstar] = procrustes(mean_shape, reference_shapes.shape1);
    aligned_mean_shape = alignment(Rstar, tstar, sstar, mean_shape);
    
    %save the aligned mean shape as the new reference image
    field = strcat('shape',num2str(it+1));
    reference_shapes.(field) = aligned_mean_shape;
end

save('reference_shapes', 'reference_shapes')
save('aligned_shapes', 'aligned_shapes')

figure(2)
imagesc(dmsa_images(:,:,1))
colormap(gray)
axis xy
hold on
axis equal
test = complex(reference_shapes.shape6(:,1), reference_shapes.shape6(:,2));
drawshape_comp(test,[1 14 1],'.-r')