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

%% Generar poligono
M = getPolygon(n_vertices,polygon_radius,rad_var,ang_var);

pts_s = [M(:,1) M(:,2)];
pts_e = [M(:,3) M(:,4)];

%theta = pi/2;
%pts_s2 = rotatePolygon(pts_s, theta);
%pts_e2 = rotatePolygon(pts_e, theta);
%M2 = [pts_s2' pts_e2'];

%figure('Position',[10 100 500 500],'Renderer','zbuffer');
%line([M2(:,1)';M2(:,3)'],[M2(:,2)';M2(:,4)'],'Color','r');
%title('Intersection Points');
%% 

[Path, D, Lines] = getPath(M, dx, curve_radius);

figure('Position',[10 100 500 500],'Renderer','zbuffer');
line([M(:,1)';M(:,3)'],[M(:,2)';M(:,4)'],'Color','r');
hold on
plot(Path(:,1), Path(:,2));
title('Original Polygon');


steps = 100;
diam = zeros(steps+1,1);
LL = zeros(steps+1,2);
length = zeros(steps+1,5);
x = 0:pi/steps:pi;

i=1;
for theta = 0:pi/steps:pi
    pts_s2 = rotatePolygon(pts_s, theta);
    pts_e2 = rotatePolygon(pts_e, theta);
    M2 = [pts_s2' pts_e2'];
    diam(i) = diameter(M2);
    [Path, D, Lines] = getPath(M2, dx, curve_radius);
    LL(i,:) = Lines;
    length(i,:) = [D sum(D)];
    i = i+1;
end

figure('Position',[500 90 500 500],'Renderer','zbuffer');
plot(x,diam)
title('Diameter function')
ylabel('Diameter')   

figure('Position',[500 190 500 500],'Renderer','zbuffer');
hold on;
plot(x,length(:,1),'c-')
plot(x,length(:,2),'r-')
plot(x,length(:,3),'b-')
plot(x,length(:,4),'g--')
plot(x,length(:,5))
hold off;
title('Path length')
ylabel('meters')

figure('Position',[500 90 500 500],'Renderer','zbuffer');
hold on;
plot(x,LL(:,1),'c-')
plot(x,LL(:,2),'r-')
title('Diameter function')
ylabel('Diameter')
