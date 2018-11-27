clc; clear all; close all;

path = '/home/minhvu/github/3DUnetCNN/brats/data/original/';

% rdir([matlabroot, '\**\*tmpl*.m'])

% dir = rdir([path, '/*.nii.gz'])

dir = rdir([path, '/**/*.nii.gz']);

disp(size(dir,1))


parpool(6)
parfor i=1:size(dir,1)
    disp('-------------------------------------------------------------')
    fprintf('processing: %s \n', dir(i).name)
    disp('-------------------------------------------------------------')
    disp('Reading volume')
    path_src = dir(i).name;
    V = niftiread(path_src);
    disp('Making dir');
    [filepath,name,ext] = fileparts(path_src);
    path_make = strrep(filepath,'original','denoised');
    mkdir(path_make)
    
    path_dest = strrep(path_src,'original','denoised');
    if isfile(path_dest)
        disp('done already...')
    else
        path_temp = strrep(path_dest,'.nii.gz','.nii');
    
        disp('Denoising started');
        y_est_auto = bm4d(V);
        disp('Writing volume');
        niftiwrite(y_est_auto,path_temp)
        gzip(path_temp)
        disp('Deleting nii');
        delete(path_temp) 
    end  
end