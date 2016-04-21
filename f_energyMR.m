%objetive function

function [energy, D, gamma_return] = f_energyMR(M, dx, curve_radius, v, w, gamma_w, b0, b1 ,b2)
        
    %gamma_w = pi/4;
    %u = 10;
    %r = 15;
    %t0 = 0;
    %t1 = 4;
    
    %% Calculate path
    %disp('Calculate path');
    [Path, D] = getPathMR(M, dx, curve_radius);

    % D = [lb lf ll lr];
    lb = D(1);
    lf = D(2);
    ll = D(3);
    lr = D(4);
    %ltotal = lf + lb +ll+ lr;
    %ltotal = lf + lb; %remove
    
    %% Calculate energy
    %disp('Estimate energy');
    v
    power_mr = @(v, w, angle, b0, b1, b2) b0 + b1 * abs(v - w*cos(angle)) + b2 * abs(w * sin(angle));
    
    % fordward energy
    theta = pi/2;
    t = lf/v;
    gamma = gamma_w-theta;
    gamma_return = gamma;
    p = power_mr(v,w,gamma,b0,b1,b2);
    ef = p * t;       
    
    %backward energy
    theta = 3*pi/2;
    t = lb/v;
    gamma = gamma_w-theta;
    p = power_mr(v, w, gamma, b0, b1, b2);
    eb = p * t;
    
    %right energy
    theta = 0;
    er = 0;
    
    %left energy
    theta = 0;
    el = 0;
    
    energy = ef + eb + el + er;
    %pause
    %exit 0
end