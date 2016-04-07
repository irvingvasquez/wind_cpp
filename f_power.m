function p = f_power(t,b0,b1,b2,w,gamma_w, u, r) 

p = b0 + b1 * abs(w * cos(f_gamma(gamma_w, u, r, t))) + b2 * abs(w * sin(f_gamma(gamma_w, u, r, t)));

end