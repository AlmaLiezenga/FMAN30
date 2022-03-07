load('reference_shapes.mat');
load('dmsa_images.mat')
load('models.mat');

figure
imagesc(dmsa_images(:,:,1))
colormap(gray)
axis xy
hold on
axis equal

test = complex(reference_shapes.shape6(:,1), reference_shapes.shape6(:,2)); 
drawshape_comp(test,[1 14 1],'.-r')
