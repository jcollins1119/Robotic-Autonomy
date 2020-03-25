% intFxWx.m programmed by Tomo Furukawa
function F = intFxWx(x, fx)

nx = length(x);
dx = (x(nx) - x(1))/(nx - 1);
F = sum(fx) * dx;
