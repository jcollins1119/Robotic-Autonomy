% normFxWx.m programmed by Tomo Furukawa
function normfx = normFxWx(x, fx)

Fx = intFxWx(x, fx);
normfx = fx / Fx;
