% normFxyWxy.m programmed by Tomo Furukawa
function normfxy = normFxyWxy(x, y, fxy)

Fxy = intFxyWxy(x, y, fxy);
normfxy = fxy / Fxy;
