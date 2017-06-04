% do pca on feature matrix

load('feature_matrix.mat')
[coeff, score, latent] = pca(feature_matrix);
newplot = score(:, 1:20); %20 dimensions but this is a good representation

scatter3(newplot(:,1), newplot(:,2), newplot(:,3), 10, continent_vector, 'filled');


save pca newplot
save pca_coeff coeff
%feature 2 is important
% components    = cumsum(latent)/sum(latent);
% plot(components);


