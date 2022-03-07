function [imvol, im, info, dimensions] = mydicomreadfolder(foldername)
%[im,info] = mydicomreadfolder(foldername)
%Reads all dicom files in a folder into an image volume.
%
%-im is a three dimensional array of image data
%-info is a struct containing suitable data for voxel sizes etc.
%
%See also MYDICOMINFO, MYDICOMREAD
%
%This function is just a stub and you need to write it.

%Stub written by Einar Heiberg

%Hint:
%To get all files called in a folder, use the function 

%Hint: Consider preallocating data for the sake of speed.

%Hint: waitbar is a good way of updating regarding progress.

%--- Initialize
im = [];
info = [];

%If called without input argument then ask for folder.
if nargin==0
  foldername = uigetdir(pwd, 'Select a folder');
end;

%Display folder name
disp(sprintf('Reading the folder %s.',foldername)); %#ok<DSPS>

%--- From now on it is up to you :-)
files = dir([foldername filesep '*.dcm']); 

file1 = files(1).name;
ffname = strcat(foldername, '/', file1); 
[info, im] = mydicomread(ffname); 
imvol = []; 

for f = 1:length(files)
    %write the image 
    ffname = fullfile(files(f).folder, files(f).name); 
    [info, im] = mydicomread(ffname); 
    imvol(:,:,f) = im; 
end

%determine the dimensions
size_dim1 = info.Columns * info.PixelSpacing(2); 
size_dim2 = info.Rows * info.PixelSpacing(1);
size_dim3 = (info.SliceThickness + info.SpacingBetweenSlices) * length(files);
dimensions = [size_dim1, size_dim2, size_dim3]; 

