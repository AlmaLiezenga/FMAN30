%load('RANSAC_resultsn2.mat'); 
load('RANSAC_resultsn2t20.mat'); 
load('HEpeData.mat'); 

%choose image
i = 8;
j = 0;

%extract R, t and the images 
field = strcat('image',num2str(i),num2str(j));

I1 = data.(field).he_original;
I2 = data.(field).pe_original; 

Rstar = best.(field).Rstar; 
tstar = best.(field).tstar; 

display(Rstar)
display(tstar)
display(best.(field).inliers)

%from the assinment description
T = [Rstar, tstar ; % s*R, t in assignment but we don't have s
    0, 0, 1];

tform = affine2d(T'); 
I1_warp = imwarp(I1, tform, 'OutputView', imref2d(size(I2))); 

figure; clf;
imshow(imfuse(I2, I1_warp, 'blend'));