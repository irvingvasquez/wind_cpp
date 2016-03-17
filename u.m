function [X Y] = fu(t, W)
 X = cos(t);
 Y = sin(t);
 X1 = t * W(1,1);
 Y1 = t * W(1,2);
 X = X - X1;
 Y = Y - Y1;
end