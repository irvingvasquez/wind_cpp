%objetive function

function [energy, D, gamma_return] = f_energy_MR_poly(M, dx, curve_radius, v, w, gamma_w, b0, b1 ,b2)
        
    velocity = [2 4 6 8 10 12 14 16];
    power = [220  215 210  208 212 230 260 300];
    %plot(velocity, power, 'o');
    p = polyfit(velocity,power,3);
    %t2 = 0:0.1:16;
    %y2 = polyval(p,t2);
    %figure
    %plot(velocity,power,'o',t2,y2)
    %title('Plot of Data (Points) and Model (Line)')


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
    %power_mr = @(v, w, angle, b0, b1, b2) b0 + b1 * abs(v - w*cos(angle)) + b2 * abs(w * sin(angle));
    power_mr = @(v, w, angle, b0, b1, b2) polyval(p,(abs(v - w*cos(angle)))) + polyval(p, abs(w * sin(angle))); 
    
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
    t = lr/v;
    gamma = gamma_w-theta;
    p = power_mr(v,w,gamma,b0,b1,b2);
    er = p * t;
    
    %left energy
    theta = 0;
    t = ll/v;
    gamma = gamma_w-theta;
    p = power_mr(v,w,gamma,b0,b1,b2);
    el = p * t;
    
    energy = ef + eb + el + er;
    %pause
    %exit 0
end