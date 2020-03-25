% intF1xzF2xWx.m programmed by Tomo Furukawa
function Fz = intF1xzF2xWx(x, f1xz, f2x)

n = length(x);

for i = 1:n
    fxz = f1xz(i,:) .* f2x;
    Fz(i) = intFxWx(x, fxz);
end
