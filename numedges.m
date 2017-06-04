% Returns the total number of edges given the adjacency matrix
% Valid for both directed and undirected, simple or general graph
% INPUTs: adjacency matrix
% OUTPUTs: m - total number of edges/links
% Other routines used: selfloops.m, issymmetric.m
% GB, Last Updated: October 1, 2009

function m = numedges(adj)

sl=selfloops(adj); % counting the number of self-loops

    m=sum(sum(adj))/2; 
    return