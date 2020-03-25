% test_GRBE1dwSN.m programmed by Tomo Furukawa
clear all;
close all;

xmin = -10;   xmax = 10;   nx = 100;
X = create_space1d(xmin, xmax, nx);

T.mx0 = 0;   T.Sx0 = 1.5;
T.mxkGxkm = 0;   T.SxkGxkm = 1;

ns = 4;
S(1).xk = -2; S(2).xk = 0.8; S(3).xk = 7; S(4).xk = 1.4;
S(1).zk = 1.43; S(2).zk = 1.09;  S(3).zk = 0.38; S(4).zk = 0.82;

X.px0 = gauss1d(X.x, T.mx0, T.Sx0);
X.pxkmGz1tkm = X.px0;

for i = 1:nx+1 % pxkGxkm(xk|xkm)
    T.pxkGxkm(:,i) = gauss1d(X.x, X.x(i)+1+T.mxkGxkm, T.SxkGxkm);
end
X.pxkGz1tkm = predict1d(X.x, T.pxkGxkm, X.pxkmGz1tkm);

[X.lxkGzk, S] = fuse1d(X.x, nx, S, ns);
X.pxkGz1tk = correct1d(X.x, X.lxkGzk, X.pxkGz1tkm);

plot(X.x, X.pxkmGz1tkm);    hold on;
plot(X.x, X.pxkGz1tkm, 'r');
plot(X.x, X.pxkGz1tk, 'k');
xlabel('x');    ylabel('p');
legend('p(x_{k-1}|z_{1:k-1})', 'p(x_k|z_{1:k-1})', 'p(x_k|z_{1:k})')
axis([-10,10,0,1]);  

X.pxkmGz1tkm = X.pxkGz1tk;    hold off;