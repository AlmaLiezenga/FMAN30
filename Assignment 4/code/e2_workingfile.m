%reading a 3D image
foldername = '/Users/almaliezenga/Documents/EPA/Lund/FMAN30/Assignment 4/code/images/MR-thorax-transversal'; 
[imvol, im, info, dimensions] = mydicomreadfolder(foldername);

%setting how we can get one of the dimensions
sizes = size(imvol); 

%transveral = squeeze(imvol(:, :, sizes(3)/2));
%imagesc([0,dimensions(1)], [0, dimensions(2)], transveral); 

%coronal = transpose(squeeze(imvol(sizes(1)/2, :, :)));
%imagesc([0,dimensions(1)], [0, dimensions(3)], coronal);

sagital = transpose(squeeze(imvol(:, sizes(2)/2, :)));
imagesc([0, dimensions(2)], [0,dimensions(3)], sagital);

%settings for displaying the image
set(gca,'xcolor',[1 1 1],'ycolor',[1 1 1]);
set(gca,'ticklength',[0.05 0.05]);

axis image 
colormap(gray)
colorbar