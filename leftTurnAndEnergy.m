% Returns a set of points of the curved path and returns the estimated
% energy
function [X,Y] = leftTurnAndEnergy(P, radius, theta0, theta1, steep, u, w, gamma_w, b0, b1 ,b2)

    power_left = @(t,b0,b1,b2,w,gamma_w, u, r) b0 + b1 * abs(w * cos(f_gamma(gamma_w, u, r, t))) + b2 * abs(w * sin(f_gamma(gamma_w, u, r, t)));


    Theta = theta0:steep:theta1;
    X = radius * cos(Theta);
    X = P(1,1) + X;
    
    Y = radius * sin(Theta);
    Y = P(1,2) + Y;
end