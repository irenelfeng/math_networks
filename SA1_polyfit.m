%% SA1_polyfit.m 

%% plot polynomial regression (1st, 2nd, 3rd, 4th, and 5th)

load('dat.mat');
x = transpose(x);
y = transpose(y);
plot(x, y, 'o');

p = polyfit(x,y, 1);
x1 = linspace(1,-1);
fit = polyval(p, x1);
h = animatedline(x1, fit, 'Color', 'r');
title('1');
pause(1);

%2nd through 5th-order polynomial
for i=2:5 
    p = polyfit(x,y, i);
    fit = polyval(p, x1);
    clearpoints(h);
    addpoints(h, x1, fit);
    title(i);
    pause(1);
end

%now do linear algebra to do 5th order polynomial 
A = [x.^5 x.^4 x.^3 x.^2 x ones(length(x), 1)];
% solve p for Ap = b. Using my variables, solve t for At = y. 
t = A\y;
% t should be the same as p! :)