%install VL feat
run('VLFEATROOT/toolbox/vl_setup')

%iterate over all possible files, process images with single precision, greyscaling and resizing and save the images in a struct
data = struct(); 

HE_dir = '/Users/almaliezenga/Documents/EPA/Lund/FMAN30/Assignment 2/Assignment-2-Data/Collection 1/HE/';
pe_dir = '/Users/almaliezenga/Documents/EPA/Lund/FMAN30/Assignment 2/Assignment-2-Data/Collection 1/p63AMACR/';
           
for i=1:9
    for j=1:8
        file = strcat(num2str(i-1), '.', num2str(j-1), '.bmp'); 
        HE_dirfile = strcat(HE_dir, file); 
        pe_dirfile = strcat(pe_dir, file);    
        
        if isfile(HE_dirfile) && isfile(pe_dirfile)
            field = strcat('image', num2str(i-1), num2str(j-1)); 
            
            %save the images in the struct
            HE = imread(HE_dirfile); 
            data.(field).he = rgb2gray(im2single(HE));
            data.(field).he_original = HE; 
            
            pe = imread(pe_dirfile);
            data.(field).pe = rgb2gray(im2single(pe));
            data.(field).pe_original = pe; 
            
            %sift descriptors
            [data.(field).hek, data.(field).hed] = vl_sift(data.(field).he); 
            [data.(field).pek, data.(field).ped] = vl_sift(data.(field).pe);
            
            %matches and scores
            [data.(field).matches, ~] = vl_ubcmatch(data.(field).hed, data.(field).ped);
        end 
    end
end

save('HEpeData', 'data'); 