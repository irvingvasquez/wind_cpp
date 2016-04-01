%objetive function

function [energy, D] = f_energy(M, dx, curve_radius, u, w, gamma_w)
    b0 = 200; %watts
    b0 = 1; %REMOVE
    b1 = 0.0;
    b2 = 0.0;
    
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
    
    % Estimate velocity
    theta = pi/2;
    vf = u * sin(theta) + w * sin(gamma_w);
    
    theta = 3*pi/2;
    vb = u * sin(theta) + w * sin(gamma_w);
    % Estimate the Power consumption
        
    %energy
    theta = pi/2;
    gamma = gamma_w - theta;
    ef = b0*lf/vf + b1 * w * cos (gamma) * lf/vf + b2 * w * sin(gamma) * lf/vf
    
    theta = 3*pi/2;
    gamma = gamma_w - theta;
    % coloque abs por que la función de potencia es positiva siempre, si la
    % velocidad es negativa aún se consume potencia, sin embargo la
    % regresión tiene una función lineal positiva 
    eb = b0*lb/abs(vb) + b1* abs(w*cos(gamma)) * lb/abs(vb) + b2* abs(w*sin(gamma)) * lb/abs(vb)
    
    el = 0;
    er = 0;
    
    energy = ef + eb + el + er;
    %exit 0
end