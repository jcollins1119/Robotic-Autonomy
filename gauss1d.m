% gauss1d.m programmed by Tomo Furukawa
function fx=gauss1d(x, m, S)

K = sqrt(2 * pi * S);
M = -(x - m).^2 / (2 * S);
fx = exp(M) / K;
