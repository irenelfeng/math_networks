% image classification 
load('indexMap.mat');
user_images = cell2mat(indexMap.keys);

load('feature_imageID_map.mat')
load('field_connected_component_indices.mat')

images_fields = zeros(1, length(field_connected_component_indices));
for i=1:length(field_connected_component_indices)
    images_fields(i) = feature_imageID_map(field_connected_component_indices(i)); %-1 is a bug, i'll fix it later
end
common = intersect(images_fields, user_images);
users_Set=setdiff(user_images,images_fields);
%random
r = randi([1 length(users_Set)],1,10);
case_studies = users_Set(r); % index

%get kNN of the case studies from Am*n matrix
load('sparse_im_users.mat');
A = full(sparse_30000_im_users);
[IDX, D] = knnsearch(A, A(r, :), 'K', 7);


