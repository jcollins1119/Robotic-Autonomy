% normFxzWx.m programmed by Tomo Furukawa
function normfxz = normFxzWx(x, fxz)

n = length(x);

for i = 1:n
    normfxz(i,:) = normFxWx(x, fxz(i,:));
end
