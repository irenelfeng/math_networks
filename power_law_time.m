 
load('all_images_users.mat');
tbl = tabulate(images);
counts = tbl(:,2);
counts = counts(counts ~= 0);
%counts = counts(counts <= 3000); %stop at 3000

[alpha, xmin, L] = plfit(data);
fig = plplot(counts, xmin, alpha);
[p,gof]=plpva(counts, xmin, 'reps', 100);

%sliding window
p_list = zeros(1,100);
alpha_list =  zeros(1,100);
xmin_list =  zeros(1,100);
logL_list = zeros(1,100);
for i=2:30 %anywhere from 1:100
    %get a subset
    filtered = counts( counts > (i * 10) & counts <= (i * 15 + 1550));
    [alpha, xmin, L] = plfit(filtered);
    alpha_list(i) = alpha;
    xmin_list(i) = xmin;
    alpha_list(i) = L;
    [p_i,gof_i]=plpva(filtered, xmin, 'reps', 100);
    p_list(i) = p_i;
end
    
max_p = max(p_list);
index_max = find(p_list == max(p_list));
save max_p max_p
save index_max index_max
 