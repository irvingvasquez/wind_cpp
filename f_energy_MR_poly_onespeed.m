%objetive function

function [energy, D, gamma_return] = f_energy_MR_poly_onespeed(M, dx, curve_radius, v_spd, w_spd, gamma_w)
    disp('Calculating Energy');    
    velocity = [2 4 6 8 10 12 14 16];
    power = [220  215 210  208 212 230 260 300];
    %plot(velocity, power, 'o');
    coef = polyfit(velocity,power,3);
    power_mr = @(speed) polyval(coef, speed); 
    %t2 = 0:0.1:16;
    %y2 = polyval(p,t2);
    %figure
    %plot(velocity,power,'o',t2,y2)
    %title('Plot of Data (Points) and Model (Line)')


    W = [w_spd.*cos(gamma_w); w_spd.*sin(gamma_w)];
    
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
    
    % fordward energy
    theta = pi/2;
    t = lf/v_spd;
    
    V = [v_spd .* cos(theta);v_spd .* sin(theta)];
    U = V - W;
    u_spd = norm(U);
    p = power_mr(u_spd);
    ef = p * t;       
    
    gamma_return = gamma_w-theta;
    
    %backward energy
    theta = 3*pi/2;
    t = lb/v_spd;
    V = [v_spd .* cos(theta);v_spd .* sin(theta)];
    U = V - W;
    u_spd = norm(U);
    p = power_mr(u_spd);
    eb = p * t;
    
    %right energy
    theta = 0;
    t = lr/v_spd;
    V = [v_spd .* cos(theta);v_spd .* sin(theta)];
    U = V - W;
    u_spd = norm(U);
    p = power_mr(u_spd);
    er = p * t;
    
    %left energy
    theta = 0;
    t = ll/v_spd;
    V = [v_spd .* cos(theta);v_spd .* sin(theta)];
    U = V - W;
    u_spd = norm(U);
    p = power_mr(u_spd);
    el = p * t;
    
    energy = ef + eb + el + er;
    %pause
    %exit 0
end