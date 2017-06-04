% community detection 

%PART ONE: Modularity 
% load('sparse_top30000.mat');
% load the other weighted matrix
% A=full(sparse);
function modularity = community_detection(A)
    
    modularity = 0;
    deg_seq = degrees(A);

    P = zeros(size(A,1), size(A,1));
    m = numedges(A);
    for i=15494:size(A,1)

    for j=1:size(A,1)
        if i == j
            P(i,j) = 0;
        else
            P(i,j) = deg_seq(i)*deg_seq(j) / (2*m);
        end

    end

    end

    B = A - P;

    [Vectors, values] = eigs(B, 5);
    values
 
    s_maximum = zeros(size(A,1),1);

    group1 = [];

    group2 = [];
    
    if(any(diag(values) > 0))
        'next iteration'
    else
        return %returns 0, stop
    end

    for j=1:size(Vectors,1)

        %fill in s to be 1 or -1 based on eigenvector. parallel to greatest
        %eigenvector, 1st column

        if(Vectors(j, 1) <=0)

            s_maximum(j) = -1; 

            group1(end+1) = j;

        else

            s_maximum(j) = 1;

            group2(end+1) = j; end

    end
    
    modularity = transpose(s_maximum);
    
end
    
%G = graph(A);

%community = plot(G);

%community.NodeCData = transpose(s_maximum);

%save community_top_100_v1 G

%save color_community_vector modularity_field;