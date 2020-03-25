% test_correct1d.m programmed by Tomo Furukawa
clear all;
close all;

xmin = -10;   xmax = 10;   nx = 100;
X = create_space1d(xmin, xmax, nx);

mxkGzkm = 3.;     SxkGzkm = 3;
X.lxkGz1 = gauss1d(X.x, mxkGzkm, SxkGzkm);

mxkGz1tkm = 0.;   SxkGz1tkm = 1.5;
X.pxkGz1tkm = gauss1d(X.x, mxkGz1tkm, SxkGz1tkm);

X.pxkGz1tk = correct1d(X.x, X.lxkGz1, X.pxkGz1tkm);

figure(1)
plot(X.x, X.pxkGz1tkm);
hold on;
plot(X.x, X.pxkGz1tk, 'r');
xlabel('x');    ylabel('p');
legend('p(x_{k}|z_{1:k-1})', 'p(x_k|z_{1:k})')
