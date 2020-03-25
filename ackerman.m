% ackerman.m programmed by Tomo Furukawa
function [dxk, dyk, dthk] = human(xk, yk, thk, wmi, gi)

L = 0.5;
R_w = 0.1;
ratio = 8;
vi = R_w / ratio * wmi;
%alpha = 0.5;

dxk = vi .* cos(thk);
dyk = vi .* sin(thk);
dthk = vi / L .* tan(gi);
%dth = alpha / L .* gi;

