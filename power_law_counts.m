function [ fig, L , p] = power_law_counts( data )
%POWER_LAW_COUNTS Summary of this function goes here
%   Detailed explanation goes here
    [alpha, xmin, L] = plfit(data);
    fig = plplot(counts, xmin, alpha);
    [p,gof]=plpva(counts, xmin, 'reps', 100);

end

