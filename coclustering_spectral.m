%% Coclustering Method 

%% do not use B, but B is pretty easy to create. 
% load the m*n matrix
load('sparse_im_users.mat');
A = full(sparse_30000_im_users);
D2= diag(sum(A)); %n*n (column sum)
D1 = diag(sum(A, 2)); %m*m (row sum) 
% 
D1_i = D1^(-.5); 
D2_i = D2^(-.5); %these operations take awhile 
% An = D1_i*A*D2_i;
% load('An.mat');
%f = full(An);
% l = ceil(log2(110));
% [~, S, Vi] = svds(An, l+1);
% invert = sparse(1:size(S,1), 1:size(S,1), diag(S), size(An,1), size(An,2));
% An = An - invert;
% [U,S,V] = svds(An, l+1);

z = vertcat(D1_i*U, D2_i*V); % vertical concatenation, n users on top, m
%images on bottom  
C = kmeans(z, 111, 'start', 'cluster', ...
                 'EmptyAction', 'singleton');
%save co_clustering_vector z
