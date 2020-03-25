% normF1xF2xWx.m programmed by Tomo Furukawa
function Fx = normF1xF2xWx(x, f1x, f2x)

f12x = f1x .* f2x;
Fx = normFxWx(x, f12x);
