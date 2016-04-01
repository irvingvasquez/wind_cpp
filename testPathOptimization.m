clear 
clc

%% Definir valores de la simulacion
% Poligono
n_vertices = 4;
polygon_radius = 200; %meters
rad_var = 5;
ang_var = 1;

% UAV and coverage
dx = 20; % distance between lines
curve_radius = 15; %meters
u = 10; %m/s

%Wind
w = 5; %m/s
w = 0; % algo esta mal por que si el viento fuera 0 la energia debería parecerse al la distancia TODO
gamma_w = pi/4;


%% Generar poligono
M = getPolygon(n_vertices,polygon_radius,rad_var,ang_var);

% Graficar polygono
figure('Position',[10 100 500 500],'Renderer','zbuffer');
line([M(:,1)';M(:,3)'],[M(:,2)';M(:,4)'],'Color','r');
title('Original Polygon');

%% Obtener una grafica de la función energia
disp('Iniciar rotación');

steps = 100;
diam = zeros(steps+1,1);
energy = zeros(steps+1,1);
length = zeros(steps+1,5);
x = 0:pi/steps:pi;

pts_s = [M(:,1) M(:,2)];
pts_e = [M(:,3) M(:,4)];

i=1;
for theta = 0:pi/steps:pi
    % Rotate M
    pts_s2 = rotatePolygon(pts_s, theta);
    pts_e2 = rotatePolygon(pts_e, theta);
    M2 = [pts_s2' pts_e2'];
    diam(i) = diameter(M2);
    [energy(i), D] = f_energy(M2, dx, curve_radius, u, w, gamma_w);
    length(i,:) = [D sum(D)];
    i = i+1;
end

figure('Position',[500 90 500 500],'Renderer','zbuffer');
plot(x,diam)
title('Diameter function')
ylabel('Diameter')

figure('Position',[500 190 500 500],'Renderer','zbuffer');
hold on;
plot(x,length(:,1),'c--o')
plot(x,length(:,2),'r-*')
%plot(x,length(:,3),'b--o')
%plot(x,length(:,4),'g--*')
%plot(x,length(:,5))
hold off;
title('Path length')
ylabel('meters')

figure('Position',[500 290 500 500],'Renderer','zbuffer');
plot(x,energy)
title('Energy function')
ylabel('Energy')



