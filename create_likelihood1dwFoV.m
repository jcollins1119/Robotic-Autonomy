% create_likelihood1dwFoV.m programmed by Tomo Furukawa
function lxkGzk = create_likelihood1dwFoV(x, s)

if s.detectFlag == 1 % Detected
    w = 2;
    s.m = s.zk;
    s.S = (w*(s.xk-s.zk))^2;
    lxkGzk = gauss1d(x, s.m, s.S);
else % Not detected
    % Probability of detection
    s.m = s.xk;
    s.S = 1;
    l_max = max(gauss1d(x, s.m, s.S));
    lxkGzk = 1 - gauss1d(x, s.m, s.S)/l_max;
end