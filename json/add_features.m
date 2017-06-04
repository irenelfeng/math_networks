% % add features from json file given ids.

load('all_images_users.mat')
im = unique(images);
fields = {};
fields_map = containers.Map('KeyType','char', 'ValueType','any');
feature_imageID_map = containers.Map('KeyType','int64', 'ValueTYpe','any'); %maps from index -> imageID
field_count=0;
image_count=0;
feature_matrix = zeros(1,1);
for i=1:length(im)
    image_fields = meta_data(int2str(im(i)));
    if(length(image_fields) ~= 0)
       image_count = image_count +1;
       feature_imageID_map(image_count) = im(i); %index -> imageID 
    end
    for f=1:length(image_fields)
        field=char(image_fields{f});
        if (ismember(field, fields)) == 0
            %if it is in not yet in the fields, add it.
            field_count = field_count + 1;
            fields_map(field) = field_count;
            fields = [fields field];
        end
        %adds the field to feature matrix for this image
        f_num = fields_map(field);
        feature_matrix(image_count, f_num) = 1; %field fill in for image
    end
end

save feature_matrix feature_matrix
save feature_imageID_map feature_imageID_map
    
