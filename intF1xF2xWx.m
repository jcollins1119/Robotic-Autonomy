% intF1xF2xWx.m programmed by Tomo Furukawa
function Fx = intF1xF2xWx(x, fx1, fx2)

fx = fx1 .* fx2;
Fx = intFxWx(x, fx);
