load('reference_shapes.mat');
load('aligned_shapes.mat')
load('models.mat');
load('dmsa_images.mat')

total = 0; 
Xmean = reshape(aligned_mean_shape.',1,[]); 

%calculate the covariance matrix    
for d=1:40
    field = strcat('shape', num2str(d));
    Xi = reshape(aligned_shapes.(field).',1,[]);     
    dXi = Xi-Xmean;
    total = total + (transpose(dXi) * dXi);
end
    
covariance_matrix = (1/40) * total;
    
%calculate the eigenvalues and eigenvectors (shape variations)
[eigenvectors, eigenvalues] = eig(covariance_matrix); 

%final shape
shape_no = 19; 
P = eigenvectors(:,shape_no); 
gamma = eigenvalues(shape_no,shape_no);

%option 1: positive 1
k = sqrt(gamma); 
final_mode = Xmean' + k * P; 
final_reshaped = reshape(final_mode.',2,[])';
final_shape_1 = complex(final_reshaped(:,1), final_reshaped(:,2));

%option 2: positive 2
k = 2 * sqrt(gamma); 
final_mode = Xmean' + k * P; 
final_reshaped = reshape(final_mode.',2,[])';
final_shape_2 = complex(final_reshaped(:,1), final_reshaped(:,2));

%option 3: negative 1
k = sqrt(gamma); 
final_mode = Xmean' - k * P; 
final_reshaped = reshape(final_mode.',2,[])';
final_shape_3 = complex(final_reshaped(:,1), final_reshaped(:,2));

%option 4: negative 2
k = 2 * sqrt(gamma); 
final_mode = Xmean' - k * P; 
final_reshaped = reshape(final_mode.',2,[])';
final_shape_4 = complex(final_reshaped(:,1), final_reshaped(:,2));

%mean shape
mean_shape = complex(aligned_mean_shape(:,1), aligned_mean_shape(:,2)); 

%plot the modes 
figure(1)
axis xy
hold on
axis equal
drawshape_comp(mean_shape,[1 14 1],'.-k')
drawshape_comp(final_shape_1,[1 14 1],'.-r')
drawshape_comp(final_shape_2,[1 14 1],'.-g')
drawshape_comp(final_shape_3,[1 14 1],'.-b')
drawshape_comp(final_shape_4,[1 14 1],'.-c')
legend('mean shape', 'mean + sqrt(value) * vector', 'mean + 2 * sqrt(value) * vector', 'mean - sqrt(value) * vector', 'mean - 2 * sqrt(value) * vector')

