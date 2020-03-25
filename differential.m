% differential.m programmed by Tomo Furukawa
function [dxk, dyk, dthk] = differential(xk, yk, thk, wli, wri)

l = 0.2;
R_w = 0.1;
ratio = 8;

dxk = R_w / (2*ratio) * (wri + wli) * cos(thk);
dyk = R_w / (2*ratio) * (wri + wli) * sin(thk);
dthk = R_w / (l*ratio) * (wri - wli);

