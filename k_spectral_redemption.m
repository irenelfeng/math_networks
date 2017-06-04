%spectral redemption

D = diag(sum(sparse));
B = [ zeros(24543, 24543) D-eye(24543,24543); -1*eye(24543, 24543) sparse ];
[vectors, vals] = eigs(B, 240, max(max(abs(B))*size(B,1)));
deg = sum(sum(sparse));
c = deg/size(sparse,1); 
%C = kmeans(vectors, 111, 'start', 'cluster', ...
%                 'EmptyAction', 'singleton');
%save user_spectral_redemption_clusters C

             
% for fields matrix
% D = diag(sum(connected_fields_matrix));
% B = [ zeros(16583, 16583) D-eye(16583,16583); -1*eye(16583, 16583) connected_fields_matrix ];
% deg = sum(sum(connected_fields_matrix));
% c = deg/size(connected_fields_matrix,1); 
% [vectors, vals] = eigs(B, 120, max(max(abs(B))*size(B,1)));
% 
% C = kmeans(vectors, 114, 'start', 'cluster', ...
%                  'EmptyAction', 'singleton');
% 


 