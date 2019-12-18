
clc; clear all; close all;


is_laptop = false;
% path = ''

if is_laptop
    path = 'C:\Users\minhm\Documents\GitHub\3DUnetCNN_BRATS\projects\drive\database';
    dir = rdir([path, '\**\*.*']);
else
    path = '/home/minhvu/github//3DUnetCNN_BRATS/projects/drive/database';
    dir = rdir([path, '/**/*.*']);
end

disp(size(dir,1))

parpool(6)
parfor i=1:size(dir,1)
% for i=1:size(dir,1)
    disp('-------------------------------------------------------------')
    fprintf('processing: %s \n', dir(i).name)
    disp('-------------------------------------------------------------')
    
    path_src = dir(i).name;
    [filepath,name,ext] = fileparts(path_src);
    path_make = strrep(filepath,'original','denoised');
    disp('Making dir');
    mkdir(path_make)
    path_dest = strrep(path_src,'original','denoised');
    
    if isfile(path_dest)
        disp('done already...')
    elseif contains(dir(i).name, "denoised") || isfolder(dir(i).name)
        disp('skip')
        continue
    else
        if contains(dir(i).name, ".tif") 
            disp('>> apply color bm3d...')
            disp('Reading image')
            I = imread(dir(i).name);
            
            disp('Denoising started');
            [NA, yRGB_est] = CBM3D(1, I, 25);
            
            disp('Writing image');
            imwrite(yRGB_est,path_dest)
        else
            disp('>> copy...')
            copyfile(path_src, path_dest)
        end
    end
end