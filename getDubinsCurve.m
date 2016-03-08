function [P1,P2,P3,d, beta] = getDubinsCurve(Wp1, Wp2, r, dx)
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
    d = 10;
end