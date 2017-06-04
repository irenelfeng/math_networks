% get top x users and their network

x = 30000;
load('all_images_users.mat');
images_users = horzcat(images, users);
tbl = tabulate(users);
counts = tbl(:,2);
%counts = counts(counts ~= 0); % drop zeros
for n=1:2 % drop two outliers users
    index = find(counts == max(counts));
    %counts = counts(counts ~= max(counts));% actually remove all instances
    counts(index) = 0;
end


top_users = zeros(x,1); %vector
n = 1;
while n <= x % creates a list of the top_users
    indexes = find(counts == max(counts)); % get array of user_ids with the next highest score
    % CHANGE: just change all instances of the counts to 0s afterwards, to
    % match userid with index
    %counts = counts(counts ~= max(counts));% actually remove all instances
    %of the counts: WOULD RUIN INDEX -> USERID
    for i=1:length(indexes) 
        top_users(n) = indexes(i); %add the top user
        %here: the actual id. 
        counts(indexes(i)) = 0;
        n=n+1;
    end
end
image_users_top = images_users(ismember(images_users(:,2),top_users),:); %gets top users
images = image_users_top(:,1);
im=unique(images);
users = image_users_top(:,2);

%deconstruct it again
save image_users_top images users
image_users_top = load('image_users_top.mat');

sparse = convertImageUsersToGraph(im, image_users_top);
save sparse_top30000 sparse
