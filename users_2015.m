times = h5read('image_id_user_id_click_sharewithDan.h5','/time_stamp');
firrst = 0;
for t=1:size(times,1)
    time = char(times(t,1));
    if strcmp(time(1:4), '2015') == 1
        firrst = t; % gets index
        break
    end
end

images = h5read('image_id_user_id_click_sharewithDan.h5','/image_id');
users = h5read('image_id_user_id_click_sharewithDan.h5','/user_id');
save all_images_users images users
users = users(firrst:end);
images = images(firrst:end);
save image_users images users

%% call adjacency 
% image_users = load('/Users/irenefeng/Documents/MATLAB/Behance/image_users.mat');
% im = unique(image_users.images)
% convertImageUsersToGraph(im, image_users)

% just get the top two users 
images_users = horzcat(images,users);
tbl = tabulate(users);
counts = tbl(:,2);
index = find(counts == max(counts));
image_users_two = images_users(~ismember(images_users(:,2),[2336255, 3117723]),:); %remove top two users
im = unique(images);
save image_two images users
image_two = load('image_two.mat');
convertImageUsersToGraph(im, image_two);
