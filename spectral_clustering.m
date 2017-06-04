%spectral clustering 

% Convert to Weighted 
% Calculate Laplacian 
% Make n null models, and calculate their Laplacians
% get minimum eigen values of all
% then get the eigenvalues of the calculated laplacian smaller than this
% eigenvalue
% k-means on the corresponding eigenvectors

%FIRST: on user-behavior sparse matrix 
%Already a weighted matrix
%Calculate Laplacian
% load('sparse_top30000.mat');
%Diag = diag(sum(sparse));
%L_user = Diag - sparse;
% comment out next 4  lines if you don't want normalized Laplacian
% %   avoid dividing by zero
%     Diag(Diag == 0) = eps;
% %     calculate inverse of D
%     Diag = spdiags(1./R_Diag, 0, size(R_Diag, 1), size(R_Diag, 2));
%L_user = Diag * L_user; %RW Laplacian

% diff   = eps;
% TODO: look at elbowology
% [eigV, eigL]= eig(L_user); %%too_long
% eigL = eigL(1:20, 1:20);
% eigV = eigV(:, 1:20);
% save sparse_30000_20_eigs eigL eigV

% make n null models, calculate their laplacians
%%FIELDLER VALUE
% load('image_users_top.mat');
% images_users = horzcat(images, users);
% images = images_users(:,1);
% im = unique(images);

% field1 = 'images';
% field2 = 'users';
% fieldler = 10000;
% for null=1:35
%     p = randperm(size(images_users,1)); %number of rows
%     random_users = zeros(size(images_users,1), 1); 
%     for i=1:length(p)
%         random_users(i) = images_users(p(i), 2); %users randomized
%         %so preserves degree sequence - is this too systematic? every node
%         %has the same number of edges, but just different images that it's
%         %connected to.... 
%     end
%     %now create a random graph
%     bleh = struct(field1,images,field2,random_users); 
%     null_model = convertImageUsersToGraph(im,bleh);
%     R_Diag = diag(sum(null_model));
%     L_rand = R_Diag - null_model;
%     
%     % comment out to line 55 if you do not want normalized laplacian 
%     % avoid dividing by zero
%     %R_Diag(R_Diag == 0) = eps;
%     % calculate inverse of D
%     %R_Diag = spdiags(1./R_Diag, 0, size(R_Diag, 1), size(R_Diag, 2));
%     %L_rand = R_Diag * L_rand; %L = D^(-1)[D-W]
%     [U, r_eigL] = eigs(L_rand, 2, diff); %get the two smallest (one being 0)
%     if( r_eigL(2,2) < fieldler)
%         %set new min
%         fieldler = r_eigL(2,2);
%     end
% end

% [U, eigVal] = eigs(L_user, 10, eps); %10 larger than eps, to be safe.
% indices = find(diag(eigVal) < fieldler);
% indices(indices ==1) = []; % drop the first eigenvector. 
% eigV = U(indices, :);
% k = length(indices); %number of eigenvectors
% 
% %get the number of eigL's lower than this random fieldler value 
% % corresponding to cluster number
% if(eigV)
%     C = kmeans(eigV, k, 'start', 'cluster', ...
%                     'EmptyAction', 'singleton');
%              
%     % now convert C to a n-by-k matrix containing the k indicator
%     % vectors as columns
%     Fin = sparse(1:size(full(sparse), 1), C, 1);
% else
%     'No clusters'
% end



% SECOND: on field matrix

 %1.  Convert to Weighted Adj. Matrix
%load the pca
%load('pca.mat');

% W = SimGraph_NearestNeighbors(transpose(pca), 300, 1, 1);
% save Sim_Fields_Matrix W;
load('Sim_Fields_Matrix.mat');
%connected component 
load('field_connected_component_indices.mat');
F = W(field_connected_component_indices, field_connected_component_indices); % just the conn. comp
%p = ((nnz(W))/size(W,2))/(size(W,2)-1); %avg degree/n-1
p = ((sum(degrees(F))/size(F,1))/(size(F,1)-1));

%random null models 
%small world model - retains transitivity
fieldler = 10000;
for null=1:100
    null_model = smallw(size(F,1), 300, p);
    R_Diag = diag(sum(null_model));
    L_rand = R_Diag - null_model;
% comment out to line 55 if you do not want normalized laplacian 
%     % avoid dividing by zero
%     %R_Diag(R_Diag == 0) = eps;
%     % calculate inverse of D
%     %R_Diag = spdiags(1./R_Diag, 0, size(R_Diag, 1), size(R_Diag, 2));
%     %L_rand = R_Diag * L_rand; %L = D^(-1)[D-W]
    [U, r_eigL] = eigs(L_rand, 2, eps); %get the two smallest (one being 0)
    if( r_eigL(2,2) < fieldler & r_eigL(2,2) > 0)
        %set new min
        fieldler = r_eigL(2,2);
    elseif(r_eigL(1,1) < fieldler & r_eigL(1,1) > 0)
        %sometimes not ordered correctly
        fieldler = r_eigL(1,1);
    end
end

%calculate Laplacian
Diag = diag(sum(F));
L_user = Diag - F;
% comment out next 4  lines if you don't want normalized Laplacian
% %   avoid dividing by zero
%     Diag(Diag == 0) = eps;
% %     calculate inverse of D
%     Diag = spdiags(1./R_Diag, 0, size(R_Diag, 1), size(R_Diag, 2));
%L_user = Diag * L_user; %RW Laplacian

[U, eigVal] = eigs(L_user, 10); %largest magnitude 
indices = find(diag(eigVal) < fieldler & diag(eigVal) > eps);
%indices(indices ==1) = []; % drop the first eigenvector. 
%eigV = U(indices, :);
%eigV = U(9:19, :); 
%k = length(indices); %number of eigenvectors
%save eigenVector_Fields_SC eigV
%C = kmeans(U, k, 'start', 'cluster', ...
%                 'EmptyAction', 'singleton');
             
% now convert C to a n-by-k matrix containing the k indicator
% vectors as columns
%C = sparse(1:size(full(sparse), 1), C, 1);



 
 