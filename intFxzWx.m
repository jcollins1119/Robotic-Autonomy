% intFxzWx.m programmed by Tomo Furukawa
function Fz = intFxzWx(x, fxz)

n = length(x);

for i = 1:n
    Fz(i) = intFxWx(x, fxz(i,:));
end
