% gauss2d.m programmed by Tomo Furukawa
function fxyi = gauss2d(xi, yi, m, S)

detS = det(S);
invS = inv(S);
[nx, ny] = size(xi);

K = 2 * pi * sqrt(detS);
e1 = xi - m(1);
e2 = yi - m(2);
for i = 1:nx
    for j = 1:ny
        e = [e1(i,j);e2(i,j)];
        M(i,j) = -0.5 * e' * invS * e;
    end
end
fxyi = exp(M) / K;
