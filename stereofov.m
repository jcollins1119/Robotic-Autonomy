% hfov.m programmed by Tomo Furukawa
function [xi, yi] = stereofov(di, pi)
pl = 30;
pr = 30

yl = 30
xi = di .* sin(pi);
yi = di .* cos(pi);
