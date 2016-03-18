velocity = [2 4 6 8 10 12 14 16];
power = [220  215 210  208 212 230 260 300];

plot(velocity, power, 'o');

p = polyfit(velocity,power,3);

t2 = 0:0.1:16;
y2 = polyval(p,t2);

figure
plot(velocity,power,'o',t2,y2)
title('Plot of Data (Points) and Model (Line)')