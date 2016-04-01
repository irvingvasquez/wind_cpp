clc;
clear;

power_left = @(t,b0,b1,b2,w,gamma_w, u, r) b0 + b1 * w * cos(f_gamma(gamma_w, u, r, t)) + b2 * w * sin(f_gamma(gamma_w, u, r, t));

b0 = 200;
b1 = 1;
b2 = 1;
w = 5;
gamma_w = pi/4;
u = 10;
r = 15;
t0 = 0;
t1 = 4;

steep = 100;

i=1;
for tmax = 0:t1/steep:t1;
    gamma(i) = f_gamma(gamma_w, u, r, tmax); 
    p(i) = power_left(tmax,b0,b1,b2,w,gamma_w, u, r);
    q(i) = integral(@(t)power_left(t,b0,b1,b2,w,gamma_w, u, r), t0, tmax); % integral mal
    i = i +1;
end

tt = 0:t1/steep:t1;
figure;
plot(tt,gamma);
figure;
plot(tt,p);
figure;
plot(tt,q);

