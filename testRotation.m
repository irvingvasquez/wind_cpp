clear 
clc

M = getPolygon(8,1,1,1)

figure('Position',[10 100 500 500],'Renderer','zbuffer');
line([M(:,1)';M(:,3)'],[M(:,2)';M(:,4)'],'Color','r');
title('Original Polygon');

pts_s = [M(:,1) M(:,2)];
pts_e = [M(:,3) M(:,4)];

theta = pi/2;
pts_s2 = rotatePolygon(pts_s, theta);
pts_e2 = rotatePolygon(pts_e, theta);
M2 = [pts_s2' pts_e2']

figure('Position',[10 100 500 500],'Renderer','zbuffer');
line([M2(:,1)';M2(:,3)'],[M2(:,2)';M2(:,4)'],'Color','r');
title('Intersection Points');



%% Animation
h = animatedline;
steps = 100;
diam = zeros(steps+1,1)
x = 0:pi/steps:pi

figure('Position',[500 90 500 500],'Renderer','zbuffer');
i=1;
for theta = 0:pi/steps:pi
    pts_s2 = rotatePolygon(pts_s, theta);
    pts_e2 = rotatePolygon(pts_e, theta);
    M2 = [pts_s2' pts_e2'];
    diam(i) = diameter(M2)
    i = i+1;
end

plot(x,diam)
title('Diameter function')
ylabel('Diameter')   
    
