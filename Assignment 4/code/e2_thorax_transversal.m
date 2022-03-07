%reading a 3D image
foldername = '/Users/almaliezenga/Documents/EPA/Lund/FMAN30/Assignment 4/code/images/MR-thorax-transversal'; 
[imvol, im, info, dimensions] = mydicomreadfolder(foldername);

%setting how we can get one of the dimensions
sizes = size(imvol); 

%transveral = squeeze(imvol(:, :, sizes(3)/2));
%imagesc([0,dimensions(1)], [0, dimensions(2)], transveral); 
%title('Transveral view of the Thorax')

%coronal = flipud(transpose(squeeze(imvol(sizes(1)/2, :, :))));
%imagesc([0,dimensions(1)], [0, dimensions(3)], coronal);
%title('Coronal view of the Thorax')

sagital = flipud(transpose(squeeze(imvol(:, sizes(2)/2, :))));
imagesc([0, dimensions(2)], [0,dimensions(3)], sagital);
title('Sagital view of the Thorax')

%settings for displaying the image
set(gca,'ticklength',[0.05 0.05]);

axis image 
colormap(gray)
colorbar