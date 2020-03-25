% normF1xzF2xWx.m programmed by Tomo Furukawa
function Fx = normF1xzF2xWx(x, f1xz, f2x)
 
n = length(x);
 
for i = 1:n
    Fx(i,:) = normF1xF2xWx(x, f1xz(i,:), f2x);
end
