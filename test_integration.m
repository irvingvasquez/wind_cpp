% ok revisada

clc;
clear;
close all;

power_left = @(t,b0,b1,b2,w,gamma_w, u, r) b0 + b1 * abs(w * cos(f_gamma(gamma_w, u, r, t))) + b2 * abs(w * sin(f_gamma(gamma_w, u, r, t)));
b0 = 0.0555;
b1 = 0;
b2 = 0.0111;
w = 5;
gamma_w = pi/4;
u = 10;
r = 15;
t0 = 0;
t1 = 4;

steep = 100;

i=1;
for tmax = t0:t1/steep:t1;
    gamma(i) = f_gamma(gamma_w, u, r, tmax) * 180/pi; 
    lateral_wind(i) = w * sin(f_gamma(gamma_w, u, r, tmax));
    p(i) = power_left(tmax,b0,b1,b2,w,gamma_w, u, r);
    q(i) = integral(@(t)power_left(t,b0,b1,b2,w,gamma_w, u, r), t0, tmax);
    i = i +1;
end

tt = 0:t1/steep:t1;
figure;
plot(tt,gamma);
title('Gamma');

figure;
plot(tt,lateral_wind);
title('Lateral wind');

figure;
plot(tt,p);
title('Power');

figure;
plot(tt,q);
title('Energy');
