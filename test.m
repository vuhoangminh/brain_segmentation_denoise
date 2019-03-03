path_img = 'C:\Users\minhm\Documents\GitHub\3DUnetCNN_BRATS\projects\idrid\database\data_test\original\IDRiD_55\img.png';
path_seg = 'C:\Users\minhm\Documents\GitHub\3DUnetCNN_BRATS\projects\idrid\database\data_test\original\IDRiD_55\gt.png';

img = imread(path_img);
seg = imread(path_seg);

figure; imshow(img, [])
figure; imshow(seg, [])



