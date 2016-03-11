function [X,Y] = circle(P, radius, theta0, theta1, steep)
    Theta = theta0:steep:theta1;
    X = radius * cos(Theta);
    X = P(1,1) + X;
    
    Y = radius * sin(Theta);
    Y = P(1,2) + Y;
end

