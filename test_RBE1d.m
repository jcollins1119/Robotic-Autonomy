% test_RBE1d.m programmed by Tomo Furukawa
clear all;
close all;

xmin = -10;   xmax = 10;   nx = 100;
X = create_space1d(xmin, xmax, nx);

mx0 = 0;   Sx0 = 1.5;
mxkGxkm = 0;   SxkGxkm = 1;
mxkGzk = 0;    SxkGzk = 1;

K = 4;
zk = [1.43,1.71, 3.18, 4.42];

X.px0 = gauss1d(X.x, mx0, Sx0);
X.pxkmGz1tkm = X.px0;
for k = 1:K
    for i = 1:nx % pxkGxkm(xk|xkm)
        pxkGxkm(:,i) = gauss1d(X.x, X.x(i)+1+mxkGxkm, SxkGxkm);
    end
    X.pxkGz1tkm = predict1d(X.x, pxkGxkm, X.pxkmGz1tkm);
    
    X.lxkGzk = gauss1d(X.x, zk(k)-mxkGzk, SxkGzk);
    X.pxkGz1tk = correct1d(X.x, X.lxkGzk, X.pxkGz1tkm);

    plot(X.x, X.pxkmGz1tkm);    hold on;
    plot(X.x, X.pxkGz1tkm, 'r');
    plot(X.x, X.pxkGz1tk, 'k');
    xlabel('x');    ylabel('p');
    legend('p(x_{k-1}|z_{1:k-1})', 'p(x_k|z_{1:k-1})', 'p(x_k|z_{1:k})')
    axis([-10,10,0,0.7]);  pause;

    X.pxkmGz1tkm = X.pxkGz1tk;    hold off;
end