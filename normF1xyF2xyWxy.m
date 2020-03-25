% normF1xyF2xyWxy.m programmed by Tomo Furukawa
function Fxy = normF1xyF2xyWxy(x, y, f1xy, f2xy)

f12xy = f1xy .* f2xy;
Fxy = normFxyWxy(x, y, f12xy);
