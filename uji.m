%%%%% extracting PCA features of the test image %%%%%
data_test_path = 'test';
 
%%%%%%%%%  finding number of training images in the data path specified as argument  %%%%%%%%%%
filenames = dir(fullfile(data_test_path, '*.jpg'));
total_images = numel(filenames);
class_index = zeros(total_images,1);
 
for n = 1 : total_images
    str = fullfile(data_test_path, filenames(n).name);
    test_image = imread(str);
    test_image = rgb2gray(test_image);
    [r,c] = size(test_image);
    temp = reshape(test_image',r*c,1); % creating (MxN)x1 image vector from the 2D image
    temp = double(temp)-m; % mean subtracted vector
    projtestimg = eigenfaces'*temp; % projection of test image onto the facespace
     
    %%%%% calculating & comparing the euclidian distance of all projected trained images from the projected test image %%%%%
     
    euclide_dist = [ ];
    for i=1 : size(eigenfaces,2)
        temp = (norm(projtestimg-projectimg(:,i)))^2;
        euclide_dist = [euclide_dist temp];
    end
     
    [euclide_dist_min,recognized_index] = min(euclide_dist);
    class_index(n) = train_target(recognized_index);
end
 
test_target = zeros(total_images,1);
num_img = 5;
num_face = 10;
 
for i = 1 : num_face
    test_target((i-1)*num_img+1:i*num_img) = i;
end
 
[~,b] = find(class_index==test_target);
test_accuracy = sum(b)/total_images*100
save('pca','projectimg','eigenfaces','train_target','m')