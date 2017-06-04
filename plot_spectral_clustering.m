% plot spectral clustering 

load('sparse_30000_20_eigs.mat');
load('spectral_cluster_users.mat');
% didn't actually save the eigenvalues oops oh well 
% take the eigenvector we want - 2nd and plot

scatter(eigV(:,2), zeros(size(eigV,1),1), 10, C);
% color based on C
