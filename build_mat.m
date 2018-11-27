clc; clear all; close all;

IS_WINDOWS = 1;

DATASET = ["data_train", "data_valid"];
DATASET_TYPE = ["original", "preprocessed"];
PATH = 'C:\Users\minhm\Documents\GitHub\3DUnetCNN\brats\';

for idx = 1:numel(DATASET)
    dataset = DATASET(idx);
    for idy = 1:numel(DATASET_TYPE)
        type = DATASET_TYPE(idy);
        path = strcat(PATH,dataset,"\",type,"\");
        fprintf('------------------------------------------------------------- \n')
        fprintf("processing %s", path)
        fprintf('\n ------------------------------------------------------------- \n')
        isempty(path)
        dir = rdir([path, '\**\*.nii.gz']);
        disp(size(dir,1))
    end
end