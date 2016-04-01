function p = power_circunfleja(w, gamma)
    x1 = w * cos(gamma);
    x2 = w * sin(gamma);
    
    b0 = 0;
    b1 = 0.1;
    b2 = 1;
    
    p = b0 + b1 * x1 + b2 * x2;
end