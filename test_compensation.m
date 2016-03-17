W = [0.1 0.1];
T = 0:0.1:pi;
[Xu Yu] = fu(T,W);
[Xx Yx] = fx(T);
plot(X, Y)
hold on
plot(Xx,Yx)

wx = W(1,1);
wy = W(1,2);
%fun = @(x) exp(-x.^2).*log(x).^2;
%fun = @(x) sqrt( (-sin(t)-wx).* (-sin(t)-wx) + (cos(t)-wy).*(cos(t)-wy) );
fu_prima = @(x) sqrt((-sin(x)-wx).^2 + (cos(x)-wy).^2); 
longitud = integral(fu_prima, 0, pi)