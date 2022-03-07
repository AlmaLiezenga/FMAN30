%reading a 3D image
foldername = '/Users/almaliezenga/Documents/EPA/Lund/FMAN30/Assignment 4/code/images/MR-carotid-coronal';
[imvol, im, info, dimensions] = mydicomreadfolder(foldername);

%setting how we can get one of the dimensions
sizes = size(imvol); 

%max_coronal = max(imvol,[],3); 
%imagesc([0,dimensions(1)], [0, dimensions(2)], max_coronal); 
%title('Coronal view of the Carotid arteries')

%max_transversal = flipud(transpose(squeeze(max(imvol,[],1)))); 
%imagesc([0, dimensions(2)], [0,dimensions(3)],  max_transversal);
%title('Transversal view of the Carotid arteries')

max_sagital = imrotate(transpose(squeeze(max(imvol,[],2))), -90); 
imagesc([0,dimensions(3)],[0, dimensions(1)], max_sagital);
title('Sagital view of the Carotid arteries')

%settings for displaying the image
set(gca,'ticklength',[0.05 0.05]);

axis image 
colormap(gray)
colorbar