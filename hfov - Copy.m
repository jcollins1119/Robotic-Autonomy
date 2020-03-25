% hfov.m programmed by Tomo Furukawa
function [xi, yi] = hfov(di, pi)

xi = di .* sin(pi);
yi = di .* cos(pi);
