% intF1xyF2xyWxy.m programmed by Tomo Furukawa
function Fxy = intF1xyF2xyWxy(x, y, f1xy, f2xy)

fxy = f1xy1 .* f2xy;
Fxy = intFxyWxy(x, y, fxy);
