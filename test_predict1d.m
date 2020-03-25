% test_predict1d.m programmed by Tomo Furukawa
clear all;
close all;

xmin = -10;   xmax = 10;   nx = 100;
X = create_space1d(xmin, xmax, nx);

mxkGxkm = 3;       SxkGxkm = 0.8;
for i = 1:nx % pxkGxkm(xk|xkm)
    pxkGxkm(:,i) = gauss1d(X.x, X.x(i)+mxkGxkm, SxkGxkm);
end

figure(1)
[X.xkmi, X.xki] = meshgrid(X.x, X.x);
surf(X.xkmi, X.xki, pxkGxkm);
axis([X.xmin, X.xmax, X.xmin, X.xmax]);
xlabel('x_{k-1}');  ylabel('x_k');
shading interp; colorbar;
pause;

mxkmGz1tkm = 0.;   SxkmGz1tkm = 1.5;
X.pxkmGz1tkm = gauss1d(X.x, mxkmGz1tkm, SxkmGz1tkm);

X.pxkGz1tkm = predict1d(X.x, pxkGxkm, X.pxkmGz1tkm);

plot(X.x, X.pxkmGz1tkm);
hold on;
plot(X.x, X.pxkGz1tkm, 'r');
xlabel('x');    ylabel('p');
legend('p(x_{k-1}|z_{1:k-1})', 'p(x_k|z_{1:k-1})')