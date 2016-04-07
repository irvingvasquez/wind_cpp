% calculates the gamma angle parametrized by time 
% We assume that the uav is turning left following a perfect circle and 
% t = 0 starts pointing to the north

function gamma = f_gammaLeft(gamma_w, u, r, t)
    gamma = gamma_w - u*t/r - pi/2;
end

