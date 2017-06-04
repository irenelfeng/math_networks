load('feature_matrix.mat');
load('field_names.mat');

% order the fields in terms of how many images fall under the category
% (most popular and shit) 

[c, highest_indices] = sort(sum(feature_matrix,1), 'descend');

table = {};
for i=1:length(highest_indices)
    table{i,1} = (fields{highest_indices(i)});
    table{i,2} = c(i);
end

% get table of country counts 

tbl = tabulate(country_vector);

table = {};
for i=1:length(tbl)
    table{i,1} = (countries{i});
    table{i,2} = tbl(i, 2);
end
