% intFxyWxy.m programmed by Tomo Furukawa
function Fxy = intFxyWxy(x, y, fxy)

ny = length(y);
for i = 1:ny % integration with respect to x
    Fy(i) = intFxWx(x, fxy(:,i));
end
Fxy = intFxWx(y, Fy); % integration with respect to y
