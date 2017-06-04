% call community_detection

%given a matrix and its modularity, do modularity analysis on its other
%components. 

function tot_modularity(A, modularity) 

    if(modularity)   
        % do modularity on  two other components
        % split the modularity vector 
        left_indices = find(modularity == 1);
        right_indices = find(modularity == 1);
        left_modularity = community_detection(A(left_indices, left_indices));
        total_modularity(A(left_indices, left_indices), left_modularity);
        
        right_modularity = community_detection(A(right_indices, right_indices));
        total_modularity(A(right_indices, right_indices), right_modularity);
    end

end                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         

