% calcula la energia utilizada para diferentes ángulos de rotación del
% polígono

clear 
clc
close all

%% Definir valores de la simulacion

% Poligono
n_vertices = 4;
polygon_radius = 200; %meters
rad_var = 5;
ang_var = 1;

% UAV and coverage
dx = 20; % distance between lines
curve_radius = 15; %meters
u = 15; %m/s

%Wind
w = 5; %m/s
gamma_w = pi/4;

%Power estimation
b0 = 0.0555;
b1 = 0;
%b2 = 0.0111;
maxb2 = 0.0111;


%% Generar poligono
M = getPolygon(n_vertices,polygon_radius,rad_var,ang_var);

% Graficar polygono
figure('Position',[10 100 500 500],'Renderer','zbuffer');
line([M(:,1)';M(:,3)'],[M(:,2)';M(:,4)'],'Color','r');
title('Polygon');
ylabel('x(meters)');
xlabel('y(meters)');


%% Obtener una grafica de la función energia
disp('Iniciar rotación');

steps = 1000;
maxrotation = pi;
diam = zeros(steps+1,1);
energy = zeros(steps+1,1);
length = zeros(steps+1,5);
gamma = zeros(steps+1,1);
x = 0:maxrotation/steps:maxrotation;
xdeg = (180/pi) .* x;

pts_s = [M(:,1) M(:,2)];
pts_e = [M(:,3) M(:,4)];


%al rotar el angulo del poligono se debe cambiar el angulo del
%viento!!!!!!!!

figure('Position',[500 290 500 500],'Renderer','zbuffer');
title('Energy')
ylabel('Energy')
xlabel('\beta (radians)')
hold on;

b2steeps = 10;
for b2 = 0:maxb2/b2steeps:maxb2
    disp('b2:'); disp(b2);
    i=1;
    for beta = 0:maxrotation/steps:maxrotation
        % Rotate M
        pts_s2 = rotatePolygon(pts_s, beta);
        pts_e2 = rotatePolygon(pts_e, beta);
        M2 = [pts_s2' pts_e2'];
        diam(i) = diameter(M2);
        gamma_w_prima = gamma_w - beta;
        [energy(i), D, gamma(i)] = f_energy(M2, dx, curve_radius, u, w, gamma_w_prima, b0, b1, b2);
        length(i,:) = [D sum(D)];
        i = i+1;
    end
    plot(xdeg,energy)
end
hold off;

figure('Position',[500 90 500 500],'Renderer','zbuffer');
plot(xdeg,diam)
title('Diameter')
ylabel('Diameter')
xlabel('\beta (degrees)')

%figure('Position',[500 90 500 500],'Renderer','zbuffer');
%plot(x,gamma)
%title('gamma angle')
%ylabel('Diameter')

figure('Position',[500 190 500 500],'Renderer','zbuffer');
hold on;
plot(xdeg,length(:,1) + length(:,2),'r--')
%plot(x,length(:,2),'r-')
plot(xdeg,length(:,3) + length(:,4),'b--')
%plot(x,length(:,4),'g-')
plot(xdeg,length(:,5))
hold off;
title('Path length')
ylabel('meters')
xlabel('\beta (degrees)')




