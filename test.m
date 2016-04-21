x = linspace(-5,5);
y1 = sin(x);
subplot(2,2,1)
plot(x,y1)
title('First subplot')

y2 = sin(2*x);
subplot(2,2,2)
plot(x,y2)
title('Second subplot')

y3 = sin(4*x);
subplot(2,2,3)
plot(x,y3)
title('Third subplot')

y4 = sin(6*x);
subplot(2,2,4)
plot(x,y4)
title('Fourth subplot')