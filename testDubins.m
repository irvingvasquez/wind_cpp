clear 
clc

Wp1 = [-1 0]
Wp2 = [1 0]
r = 2;
dx = 2;

[P1,P2,P3,d, beta] = getDubinsCurve(Wp1,Wp2,r,dx);


figure('Position',[10 100 500 500],'Renderer','zbuffer');
axes_properties.DataAspectRatio = [1 1 1];

[X Y] = circle(P1, r, 0, beta, 0.01);
plot(X,Y);
hold on
[X2 Y2] = circle(P2, r, 0-beta, pi+beta, 0.01);
plot(X2,Y2);
[X3 Y3] = circle(P3, r, pi-beta, pi, 0.01);
plot(X3,Y3);

title('Dubins Curve')