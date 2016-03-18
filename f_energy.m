%objetive function
% i = 1, fordward
% i = 2, backward
% i = 3, left curve
% i = 4, right curve
%TODO

function energy = f_energy(M, beta, i, dx, curve_radius, u, w)
    alpha1 = 1;
    alpha2 = 1;
    
    
%% Rotate M
    pts_s = [M(:,1) M(:,2)];
    pts_e = [M(:,3) M(:,4)];

    pts_s2 = rotatePolygon(pts_s, theta);
    pts_e2 = rotatePolygon(pts_e, theta);
    M2 = [pts_s2' pts_e2'];
    
    %% Calculate path
    [Path D] = getPath(M2, dx, curve_radius);
    % D = [lb lf ll lr];
        
    %% Calculate energy
    % Estimate the Power consumption
    a_i = [0.0578   -0.5254   -1.6629  225.5714]; %parameters obtained by fitting, powerFitting.m
    power = polyval(a_i, norm(u));
    
    % Estimate ground velocity
    if(i==1)
        theta = pi/2;
        v = alpha1 * (norm(u) * cos(theta) + w(1,1));
    end
    
    if(i==2)
        theta= pi + pi/2;
        v = alpha1 * (norm(u) * cos(theta) + w(1,1));
    end
    
    if(i==3)
    
    %% Estimate ground velocities
    
    
end