% Estimates the dubins path and calculates the energy by integrating the
% power over the time 
% param dir indica si el path es por arriba o por abajo. 1 superior, -1
% inferior

function [WPs, dist, Energy] = getDubinsWaypointsEnergy(Wp1, Wp2, r, dx, dir)
    % distancia entre los centros de los dos circulos izquierdo y derecho
    a = 2 * r + dx;
    temp = a/(4*r);
    % angulo entre la horizontal y la linea que une el centro del circulo
    % izquierdo con el centro del circulo superior
    beta = acos(temp);
    
    % obtener la coordenada y más arriba
    if(Wp1(1,2)>Wp2(1,2))
        yh = Wp1(1,2);
    else
        yh = Wp2(1,2);
    end
 
    % Centros de los circulos
    P1 = [(Wp1(1,1)-r) yh];
    P3 = [(Wp2(1,1)+r) yh];
    P2 = [(P1(1,1) + 2*r*cos(beta)) (P1(1,2) + 2*r*sin(beta))];
    if(dir == -1)
        P2 = [(P1(1,1) + 2*r*cos(-beta)) (P1(1,2) + 2*r*sin(-beta))];
    end
    
    % calcular Dubins curves
    if(dir == 1)
        % Superior
        % Left turn 
        [X, Y] = circle(P1, r, 0, beta, pi/10);
        
        [X2, Y2] = circle(P2, r, pi+beta, 0-beta, -pi/10);
        [X3, Y3] = circle(P3, r, pi-beta, pi, pi/10);
        WPs = [X' Y'; X2' Y2';X3' Y3'];
    else
        % Inferior
        [X, Y] = circle(P1, r, 2*pi, 2*pi-beta, -pi/10);
        [X2, Y2] = circle(P2, r, pi-beta, 2*pi+beta, pi/10);
        [X3, Y3] = circle(P3, r, pi+beta, pi, -pi/10);
        WPs = [X' Y'; X2' Y2';X3' Y3'];
    end
    
    % Calculate the total distance
    dist = r * beta + r * (pi + 2*beta) + r * beta;
end