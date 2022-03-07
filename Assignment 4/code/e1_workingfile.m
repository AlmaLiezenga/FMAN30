%reading a 2D image
[info_test1, im_test1] = mydicomread('/Users/almaliezenga/Documents/EPA/Lund/FMAN30/Assignment 4/code/images/MR-heart-single.dcm'); 
imagesc(im_test1)
colormap(gray)
colorbar

%reading a 3D image
%foldername = '/Users/almaliezenga/Documents/EPA/Lund/FMAN30/Assignment 4/code/images/MR-thorax-transversal'; 
%[imvol, im, info, dimensions] = mydicomreadfolder(foldername);

%volumeViewer(imvol)