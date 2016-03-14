function [WPs, dist] = getDubinsWaypoints(Wp1, Wp2, r, dx, dir)
    a = 2 * r + dx;
    b = 2 * r;
    temp = a/(4*r);
    beta = acos(temp);
    
    if(Wp1(1,2)>Wp2(1,2))
        yh = Wp1(1,2);
    else
        yh = Wp2(1,2);
    end
 
    P1 = [(Wp1(1,1)-r) yh];
    P3 = [(Wp2(1,1)+r) yh];
    P2 = [(P1(1,1) + 2*r*cos(beta)) (P1(1,2) + 2*r*sin(beta))];
    
    if(dir == -1)
        P2 = [(P1(1,1) + 2*r*cos(-beta)) (P1(1,2) + 2*r*sin(-beta))];
    end
    
    dist = r * beta + r * (pi + 2*beta) + r * beta;
    
    if(dir == 1)
        [X, Y] = circle(P1, r, 0, beta, pi/10)
        [X2, Y2] = circle(P2, r, pi+beta, 0-beta, -pi/10);
        [X3, Y3] = circle(P3, r, pi-beta, pi, pi/10);
        WPs = [X' Y'; X2' Y2';X3' Y3'];
    else
        [X, Y] = circle(P1, r, 2*pi, 2*pi-beta, -pi/10)
        [X2, Y2] = circle(P2, r, pi-beta, 2*pi+beta, pi/10);
        [X3, Y3] = circle(P3, r, pi+beta, pi, -pi/10);
        WPs = [X' Y'; X2' Y2';X3' Y3']
    end
end