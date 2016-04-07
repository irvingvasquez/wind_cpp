% calculates the gamma angle parametrized by time 
% We assume that the uav is turning right and starts pointing to the north
% t = 0
function gamma = f_gammaRight(gamma_w, u, r, t)
    gamma = gamma_w + u*t/r - pi/2;
end

