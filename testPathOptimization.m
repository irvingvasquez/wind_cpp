%% Definir valores de la simulacion
% Poligono
n_vertices = 4;
polygon_radius = 300; %meters
rad_var = 1;
ang_var = 1;

% UAV and coverage
dx = 10; % distance between lines
curve_radius = 15; %meters

%% Generar poligono
M = getPolygon(n_vertices,polygon_radius,rad_var,ang_var);

% Graficar polygono
figure('Position',[10 100 500 500],'Renderer','zbuffer');
line([M(:,1)';M(:,3)'],[M(:,2)';M(:,4)'],'Color','r');
title('Original Polygon');

%% Obtener una grafica de la función energia

