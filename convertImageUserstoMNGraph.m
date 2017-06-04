%convertImageUsersToMNGraph

function A = convertImageUserstoMNgraph(images, users)
    %% creates indices for itemID -> matrixID
    indexMap =  containers.Map(unique(images), [1:length(unique(images))]);
    %% creates indices for matrixID -> userID
    userIndexMap =  containers.Map([1:length(unique(users))], unique(users)); %%technically don't need but is good
    save userIndexMap userIndexMap
    
    usersMap = containers.Map('KeyType','int64', 'ValueType','any');
    for r=1:size(images,1)

        imageID = images(r);
        userID = users(r);

        if isKey(usersMap, userID)
            %% gets the list at userID and adds to it 
            usersMap(userID) = [usersMap(userID) indexMap(imageID)];
        else
            %% makes new array 
            usersMap(userID) = [ indexMap(imageID) ];
       end
    end
    
    sparse_i = [];
    sparse_u = [];
    
    user_keys = unique(users);
    for i=1: size(user_keys,1)
        images_clicked = usersMap(user_keys(i));
        for j=1: length(images_clicked)
            sparse_i(end+1) = images_clicked(j);
            sparse_u(end+1) = i;
        end
    end
            
    v = ones(size(sparse_i,1),1);
    A = sparse(sparse_i, sparse_u, v);
        

end
