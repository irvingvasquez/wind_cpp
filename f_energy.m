%objetive function

function [energy, D, Gamma] = f_energy(M, dx, curve_radius, u, w, gamma_w)
    b0 = 0.0555;
    b0 = 0;
    b1 = 0;
    b2 = 0.0111;
    w = 5;
    
    %gamma_w = pi/4;
    %u = 10;
    %r = 15;
    %t0 = 0;
    %t1 = 4;
    
    %% Calculate path
    disp('Calculate path');
    [Path, D] = getPath(M, dx, curve_radius);

    % D = [lb lf ll lr];
    lb = D(1);
    lf = D(2);
    ll = D(3);
    lr = D(4);
    %ltotal = lf + lb +ll+ lr;
    %ltotal = lf + lb; %remove
    
    %% Calculate energy
    disp('Estimate energy');
    
    % fordward energy
    theta = pi/2;
    vf = abs(u * sin(theta) + w * sin(gamma_w));
    t0 = 0;
    t1 = lf/vf;
    
    ff_gamma = @(gamma_w, theta, t) gamma_w - theta;
    
    ff_power = @(t,b0,b1,b2,w,gamma_w, theta) b0 + b1 * abs(w * cos(ff_gamma(gamma_w, theta, t))) + b2 * abs(w * sin(ff_gamma(gamma_w, theta,t)));
    
    gammaf = ff_gamma( gamma_w,theta);
    p = ff_power(0,b0,b1,b2,w,gamma_w,theta)
    ef = p * t1;
    %ef = integral(@(t)ff_power(t, b0, b1, b2, w, gamma_w, theta), t0, t1);
        
    %backward energy
    
    theta = 3*pi/2;
    vb = abs(u * sin(theta) + w * sin(gamma_w));
    t1 = lb/vb;
    gammab = ff_gamma(gamma_w,theta);
    p = ff_power(0,b0,b1,b2,w,gamma_w,theta)
    eb = p * t1;
    %eb = integral(@(t)ff_power(t, b0, b1, b2, w, gamma_w, theta), t0, t1);
    
    el = 0;
    er = 0;
    
    energy = ef + eb + el + er;
    Gamma = gammaf;
    %exit 0
end