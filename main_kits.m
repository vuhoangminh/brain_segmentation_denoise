
clc; clear all; close all;


is_laptop = false;
% path = ''

if is_laptop
    path = 'C:\Users\minhm\Documents\GitHub\3DUnetCNN_BRATS\ibsr';
    dir = rdir([path, '\**\*.nii.gz']);
else
    path = '/home/minhvu/github/3DUnetCNN_BRATS/projects/kits19';
    dir = rdir([path, '/database/data_train/original/**/*.nii.gz']);
end

disp(size(dir,1))

% parpool(6)
% parfor i=1:size(dir,1)
for i=1:size(dir,1)
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
    else
        if contains(dir(i).name, "imaging") 
            disp('>> apply bm4d...')
            disp('Reading volume')
            V = load_untouch_nii(path_src);
            V_denoised = V;
            I = V.img;
            path_temp = strrep(path_dest,'.nii.gz','.nii');

            disp('Denoising started');
            y_est_auto = bm4d(I);
            
            disp('Writing volume');
            V_denoised.img = y_est_auto;
            save_untouch_nii(V_denoised,path_temp)
            gzip(path_temp)
            disp('Deleting nii');
            delete(path_temp) 
        else
            disp('>> copy...')
            copyfile(path_src, path_dest)
        end
    end
end