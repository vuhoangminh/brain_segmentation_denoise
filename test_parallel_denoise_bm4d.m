function t = test_parallel_denoise_bm4d(path)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
t0=tic;

dir = rdir([path, '/**/*.nii.gz']);
disp(size(dir,1))

parfor i=1:size(dir,1)
% for i=1:size(dir,1)    
    disp('-------------------------------------------------------------')
    fprintf('processing: %s \n', dir(i).name)
    disp('-------------------------------------------------------------')
    disp('Reading volume')
    path_src = dir(i).name;
%     V = niftiread(path_src);
    V = load_untouch_nii(path_src);
    V_denoised = V;
    I = V.img;
    
    disp('Making dir');
    [filepath,name,ext] = fileparts(path_src);
    path_make = strrep(filepath,'original','denoised');
    mkdir(path_make)
    
    path_dest = strrep(path_src,'original','denoised');
    if isfile(path_dest)
        disp('done already...')
    else
        path_temp = strrep(path_dest,'.nii.gz','.nii');    
        
        if contains(path_src, 'seg')
            disp('Copy label volume');
        else
            disp('Denoising started');
            y_est_auto = bm4d(I);
            V_denoised.img = y_est_auto;
        end
        
        disp('Writing volume');
        save_untouch_nii(V_denoised,path_temp)
        gzip(path_temp)
        
        disp('Deleting nii');
        delete(path_temp) 
    end  
end

t=toc(t0);
end

