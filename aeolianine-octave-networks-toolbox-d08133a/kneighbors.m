function kneigh = kneighbors(adj,ind,k)

adjk = adj;
for i=1:k-1; adjk = adjk*adj; end;

kneigh = find(adjk(ind,:)>0);