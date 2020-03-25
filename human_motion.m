% ackerman.m programmed by Tomo Furukawa
function [dxk, dyk, dthk] = human_motion(xk, yk, thk, fi, si)


dxk = fi.*cos(thk);
dyk = fi.*sin(thk);
dthk = si;


