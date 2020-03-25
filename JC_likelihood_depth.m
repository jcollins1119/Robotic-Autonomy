% likelihood_vcamera.m programmed by Tomo Furukawa
function [li, detectFlag] = JC_likelihood_depth(xi, yi, PoDi, x, z)
%z is the target location
%x is the platform location

w = 0.1;
e = 0.01;
x_min = min(min(xi));   x_max = max(max(xi));
y_min = min(min(yi));   y_max = max(max(yi));
S_z = JC_itransform_p2d(z, x);
if (S_z(1) > x_min) & (S_z(1) < x_max)...
        & (S_z(2) > y_min) & (S_z(2) < y_max)
    detectFlag = 1;
    li = gauss2d(xi, yi, S_z, [w*abs(S_z(1))+e,0;0,w*abs(S_z(2))+e]);
else
    detectFlag = 0;
    li = 1 - PoDi;
end
