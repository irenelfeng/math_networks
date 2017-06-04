%% images = array of unique images, needn't be ordered. 
%% image_users = cell of images vector, users vector
%% takes about an hour for 7mil. job started 11:46 - 11:50 for create map
%% adjacency matrix started 12:55 takes hours... 
function A = convert_image_users_to_graph(images, image_users)

%% creates indices for itemID -> matrixID
indexMap =  containers.Map(images, [1:size(images,1)]);
%save indexMap indexMap
    
%% creates map of items -> users
% itemsMap = containers.Map('KeyType','int64', 'ValueType','any');
% for r=1:size(image_users.images,1)
% 
%     imageID = image_users.images(r);
%     userID = image_users.users(r);
% 
%     if isKey(itemsMap, imageID)
%         %% gets the list at imageID and adds to it 
%         itemsMap(imageID) = [itemsMap(imageID) userID];
%     else
%         %% makes new array 
%         itemsMap(imageID) = [ userID ];
%    end
% end

%% creates map of users -> items
usersMap = containers.Map('KeyType','int64', 'ValueType','any');
for r=1:size(image_users.images,1)

    imageID = image_users.images(r);
    userID = image_users.users(r);

    if isKey(usersMap, userID)
        %% gets the list at userID and adds to it 
        usersMap(userID) = [usersMap(userID) indexMap(imageID)];
    else
        %% makes new array 
        usersMap(userID) = [ indexMap(imageID) ];
   end
end

sparse_i = [];
sparse_j = [];
pair = containers.Map('KeyType','char', 'ValueType','any');
user_keys = unique(image_users.users);
for i=1: size(user_keys,1)
    images_clicked = usersMap(user_keys(i));
    for j=1: size(images_clicked,2)-1
        for k=j+1:size(images_clicked,2) %columns
            %if ~isKey(pair, [int2str(images_clicked(j)) ' ' int2str(images_clicked(k))])
            sparse_i(end+1) = images_clicked(j); % puts in index
            sparse_j(end+1) = images_clicked(k);
            sparse_i(end+1) = images_clicked(k); % puts in index symmetric
            sparse_j(end+1) = images_clicked(j);
                %pair([int2str(images_clicked(j)) ' ' int2str(images_clicked(k))]) = 1;
            %end
        end
    end
end

v = ones(size(sparse_i,1),1); %although all ones, if the sparse matrix has two matrices doubled it should weight them
A = sparse(sparse_i, sparse_j, v);
