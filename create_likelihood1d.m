% create_likelihood1d.m programmed by Tomo Furukawa
function lxkGzk = create_likelihood1d(x, s)

w = 2;
s.m = s.zk;
s.S = (w*(s.xk-s.zk))^2;
lxkGzk = gauss1d(x, s.m, s.S);
